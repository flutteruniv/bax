import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/logger.dart';
import '../../facility/data/facility_repository.dart';
import '../../map/domain/nearby_search_results/nearby_search_result.dart';
import '../data/measurement_wifi_repository.dart';

final measurementWifiServiceProvider = Provider((ref) {
  return MeasurementWifiService(ref);
});

class MeasurementWifiService {
  MeasurementWifiService(this.ref);

  final Ref ref;

  Future<void> postMeasurementResult(
    NearbySearchResult nearbySearchResult,
    double downloadSpeed,
    double uploadSpeed,
  ) async {
    final measurementWifiRepository = ref.watch(measurementWifiRepositoryProvider);
    final facilityRepository = ref.watch(facilityRepositoryProvider);

    try {
      // 計測履歴を追加する
      await measurementWifiRepository.addHistory(
        nearbySearchResult.placeId,
        nearbySearchResult.name,
        downloadSpeed,
        uploadSpeed,
      );

      // 計測履歴を取得して平均値スピードを算出する
      final histories = await measurementWifiRepository.getHistories(nearbySearchResult.placeId);
      var totalDownloadSpeed = 0.0;
      var totalUploadSpeed = 0.0;
      for (final history in histories) {
        totalDownloadSpeed += history.downloadSpeed;
        totalUploadSpeed += history.uploadSpeed;
      }
      // 平均値を算出して小数第二位で四捨五入
      final averageDownloadSpeed = double.parse((totalDownloadSpeed / histories.length).toStringAsFixed(1));
      final averageUploadSpeed = double.parse((totalUploadSpeed / histories.length).toStringAsFixed(1));

      // 施設情報を追加 or 更新する
      await facilityRepository.saveFacility(
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
        logger.w('同じ施設に対して、一日に一度の投稿しかできません');
      }
    } on Exception catch (_) {
      /// TODO: 予期せぬエラーが起きた旨を伝える
    }
  }
}
