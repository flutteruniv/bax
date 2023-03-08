import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/logger.dart';
import '../../../configs/union_timestamp.dart';
import '../../authentication/data/firebase_auth.dart';
import '../../facility/data/facility_repository.dart';
import '../../map/domain/nearby_search_results/nearby_search_result.dart';
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
  Future<void> postMeasurementResult(
    String ssid,
    FastNetResult fastNetResult,
    NearbySearchResult nearbySearchResult,
  ) async {
    final uid = ref.watch(firebaseAuthProvider).currentUser?.uid;
    if (uid == null) {
      return;
    }
    final wifiMeasurementResult = WifiMeasurementResult(
      ssid: ssid,
      downloadSpeedMbps: fastNetResult.downloadSpeedMbps,
      uploadSpeedMbps: fastNetResult.uploadSpeedMbps,
      latencyValue: fastNetResult.latencyValue,
      bufferbloatValue: fastNetResult.bufferbloatValue,
      usrISP: fastNetResult.usrISP,
      placeId: nearbySearchResult.placeId,
      uid: uid,
      terminalTime: UnionTimestamp.dateTime(
        DateTime.now().toUtc(),
      ), // ユーザーがタイムゾーンを変更して日にちをずらして投稿するという不正を防ぐため、Utcにする
    );

    final measurementWifiRepository = ref.watch(measurementWifiRepositoryProvider);
    try {
      // 計測結果を追加する
      await measurementWifiRepository.addWifiMeasurementResult(wifiMeasurementResult);

      // 同施設のこれまでの計測結果を取得して平均値スピードを算出する
      final results = await measurementWifiRepository.getWifiMeasurementResults(nearbySearchResult.placeId);
      var totalDownloadSpeed = 0.0;
      var totalUploadSpeed = 0.0;
      for (final result in results) {
        totalDownloadSpeed += result.downloadSpeedMbps;
        totalUploadSpeed += result.uploadSpeedMbps;
      }
      // 平均値を算出して小数第二位で四捨五入
      final averageDownloadSpeed = double.parse((totalDownloadSpeed / results.length).toStringAsFixed(1));
      final averageUploadSpeed = double.parse((totalUploadSpeed / results.length).toStringAsFixed(1));

      // 施設情報を追加 or 更新する
      await ref.watch(facilityRepositoryProvider).saveFacility(
            nearbySearchResult.placeId,
            nearbySearchResult.name,
            nearbySearchResult.geometry.location.latitude,
            nearbySearchResult.geometry.location.longitude,
            nearbySearchResult.vicinity,
            averageDownloadSpeed,
            averageUploadSpeed,
          );
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        /// TODO: 同じ施設に対して、一日に一度の投稿しかできない旨を伝える
        // TODO(kenta-wakasa): そもそも一度測定していたら投稿できないようにしたい
        logger.w('同じ施設に対して、一日に一度の投稿しかできません');
      }
    } on Exception catch (_) {
      /// TODO: 予期せぬエラーが起きた旨を伝える
    }
  }
}
