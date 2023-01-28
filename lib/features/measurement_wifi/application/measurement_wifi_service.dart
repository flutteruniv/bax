import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/logger.dart';
import '../data/measurement_wifi_repository.dart';

final measurementWifiServiceProvider = Provider((ref) {
  return MeasurementWifiService(ref);
});

class MeasurementWifiService {
  MeasurementWifiService(this.ref);

  final Ref ref;

  Future<void> postMeasurementResult(
      String placeId, String facilityName, double downloadSpeed, double uploadSpeed) async {
    final repository = ref.watch(measurementWifiRepositoryProvider);

    try {
      await repository.addHistory(placeId, facilityName, downloadSpeed, uploadSpeed);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        /// TODO: 同じ施設に対して、一日に一度の投稿しかできない旨を伝える
        logger.w('同じ施設に対して、一日に一度の投稿しかできません');
      }
    }
  }
}
