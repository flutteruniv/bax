import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../configs/firebase.dart';
import '../../../configs/logger.dart';
import '../domain/measurement_history.dart';

final measurementWifiRepositoryProvider = Provider(
  (ref) => MeasurementWifiRepository(
    firestore: ref.watch(firebaseFirestoreProvider),
  ),
);

class MeasurementWifiRepository {
  MeasurementWifiRepository({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  static const measurementHistoryCollectionName = 'measurementHistory';

  Future<void> addHistory(String placeId, String facilityName, double downloadSpeed, double uploadSpeed) async {
    /// TODO: uid取得処理
    const uid = 'uid';
    final now = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final docId = '$now-$uid-$placeId';
    final docRef = firestore.collection(measurementHistoryCollectionName).doc(docId);
    try {
      await docRef.set(
        MeasurementHistory(
          placeId: placeId,
          facilityName: facilityName,
          downloadSpeed: downloadSpeed,
          uploadSpeed: uploadSpeed,
        ).toJson(),
      );
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
