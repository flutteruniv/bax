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
      await measurementWifiRepository.addHistory(
        nearbySearchResult.placeId,
        nearbySearchResult.name,
        downloadSpeed,
        uploadSpeed,
      );
      await facilityRepository.saveFacility(
        nearbySearchResult.placeId,
        nearbySearchResult.name,
        nearbySearchResult.geometry.location.latitude,
        nearbySearchResult.geometry.location.longitude,
        nearbySearchResult.vicinity,
        downloadSpeed,
        uploadSpeed,
      );
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        /// TODO: 同じ施設に対して、一日に一度の投稿しかできない旨を伝える
        logger.w('同じ施設に対して、一日に一度の投稿しかできません');
      }
    }
  }
}
