import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../configs/firebase.dart';
import '../../../configs/logger.dart';
import '../domain/wifi_measurement_result.dart';

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

  static const wifiMeasurementResultCollectionName = 'wifiMeasurementResult';
  static const wifiMeasurementResultFieldPlaceId = 'placeId';
  static const wifiMeasurementResultFieldCreatedAt = 'createdAt';

  Future<void> addWifiMeasurementResult(WifiMeasurementResult result) async {
    final now = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final docId = '$now-${result.uid}-${result.placeId}';
    final docRef = firestore.collection(wifiMeasurementResultCollectionName).doc(docId);
    try {
      await docRef.set(
        result.toJson(),
      );
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<List<WifiMeasurementResult>> getWifiMeasurementResults(String placeId) async {
    final collectionRef =
        firestore.collection(wifiMeasurementResultCollectionName).withConverter<WifiMeasurementResult>(
      fromFirestore: (snapshot, options) {
        final json = snapshot.data();
        return WifiMeasurementResult.fromJson(json!);
      },
      toFirestore: (snapshot, options) {
        return snapshot.toJson();
      },
    );
    final query = collectionRef
        .where(wifiMeasurementResultFieldPlaceId, isEqualTo: placeId)
        .orderBy(wifiMeasurementResultFieldCreatedAt, descending: true)
        .limit(3);
    final snapshot = await query.get();
    return snapshot.docs.map((event) => event.data()).toList();
  }
}
