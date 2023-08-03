import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/logger.dart';
import '../../../configs/union_timestamp.dart';
import '../../authentication/data/firebase_auth.dart';
import '../../bax/domain/bax.dart';
import '../../bax/domain/bax_reasons.dart';
import '../../facility/domain/facility.dart';
import '../../payment/repository/payment_repository.dart';
import '../../user/data/user_repository.dart';
import '../data/measurement_wifi_repository.dart';
import '../domain/fast_net_result.dart';
import '../domain/wifi_measurement_result.dart';

final measurementWifiServiceProvider = Provider((ref) {
  return MeasurementWifiService(ref);
});

class MeasurementWifiService {
  MeasurementWifiService(this.ref);

  final Ref ref;

  /// wifiの測定結果を投稿する
  ///
  /// 投稿にした場合はBAXをreturnする
  ///
  /// returnしたBAXはユーザーへのフィードバックに使用する
  Future<Bax?> postMeasurementResult(
    String ssid,
    FastNetResult fastNetResult,
    Facility facility,
  ) async {
    final uid = ref.watch(firebaseAuthProvider).currentUser?.uid;
    if (uid == null) {
      return null;
    }
    final wifiMeasurementResult = WifiMeasurementResult(
      ssid: ssid,
      downloadSpeedMbps: fastNetResult.downloadSpeedMbps,
      uploadSpeedMbps: fastNetResult.uploadSpeedMbps,
      latencyValue: fastNetResult.latencyValue,
      bufferbloatValue: fastNetResult.bufferbloatValue,
      usrISP: fastNetResult.usrISP,
      placeId: facility.id,
      uid: uid,
      terminalTime: UnionTimestamp.dateTime(
        DateTime.now().toUtc(),
      ), // ユーザーがタイムゾーンを変更して日にちをずらして投稿するという不正を防ぐため、Utcにする
    );

    final measurementWifiRepository = ref.watch(measurementWifiRepositoryProvider);
    final userRepository = ref.watch(userRepositoryProvider);
    try {
      // 計測結果を追加する
      await measurementWifiRepository.addWifiMeasurementResult(wifiMeasurementResult);

      // 同施設のこれまでの計測結果を取得して平均値スピードを算出する
      final results = await measurementWifiRepository.getWifiMeasurementResults(facility.id);

      var totalDownloadSpeed = 0.0;
      var totalUploadSpeed = 0.0;
      for (final result in results) {
        totalDownloadSpeed += result.downloadSpeedMbps;
        totalUploadSpeed += result.uploadSpeedMbps;
      }
      // 平均値を算出して小数第二位で四捨五入
      final averageDownloadSpeed = double.parse((totalDownloadSpeed / results.length).toStringAsFixed(1));
      final averageUploadSpeed = double.parse((totalUploadSpeed / results.length).toStringAsFixed(1));

      await facility.docRef.set(
        facility
            .copyWith(
              downloadSpeed: averageDownloadSpeed,
              uploadSpeed: averageUploadSpeed,
            )
            .toJson(),
      );

      final bax = Bax(
        uid: uid,

        /// proであれば2倍にする
        bonusRate: ref.read(isProProvider) ? 2 : 1,
        baxReasons: [
          /// 過去に計測がなければボーナスポイントを付与
          if (results.length == 1) ref.read(baxReasonsProvider).findingNewWiFi,
          ref.read(baxReasonsProvider).measurementWifi,
        ],
      );

      /// BAX付与する
      await userRepository.giveBax(bax);
      return bax;
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        /// TODO: 同じ施設に対して、一日に一度の投稿しかできない旨を伝える
        // TODO(kenta-wakasa): そもそも一度測定していたら投稿できないようにしたい
        logger.w('同じ施設に対して、一日に一度の投稿しかできません');
      }
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
    return null;
  }
}
