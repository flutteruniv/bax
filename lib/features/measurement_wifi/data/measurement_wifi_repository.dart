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

final measurementWifiResultsForFacility = FutureProvider.autoDispose.family((ref, String placeId) {
  return ref.watch(measurementWifiRepositoryProvider).getWifiMeasurementResults(placeId, all: true);
});

class MeasurementWifiRepository {
  MeasurementWifiRepository({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  static const wifiMeasurementResultCollectionName = 'wifiMeasurementResult';
  static const wifiMeasurementResultFieldPlaceId = 'placeId';
  static const wifiMeasurementResultFieldCreatedAt = 'createdAt';

  String buildDocId({
    required DateTime today,
    required String uid,
    required String placeId,
  }) {
    final formattedToday = DateFormat('yyyy-MM-dd').format(today);
    return '$formattedToday-$uid-$placeId';
  }

  /// 本日のドキュメントが存在しているかどうかを取得する
  ///
  /// 施設への投稿は1日に1度しかできない
  Future<bool> hasTodayData({
    required String placeId,
    required DateTime today,
    required String uid,
  }) async {
    final docId = buildDocId(today: today.toUtc(), uid: uid, placeId: placeId);
    final docRef = firestore.collection(wifiMeasurementResultCollectionName).doc(docId);
    final ds = await docRef.get();
    return !ds.exists;
  }

  Future<void> addWifiMeasurementResult(WifiMeasurementResult result) async {
    final terminalDateTime = result.terminalTime.dateTime;
    if (terminalDateTime == null) {
      return;
    }
    final docId = buildDocId(today: terminalDateTime, uid: result.uid, placeId: result.placeId);
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

  Future<List<WifiMeasurementResult>> getWifiMeasurementResults(String placeId, {bool all = false}) async {
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
    final query = all
        ? collectionRef
            .where(wifiMeasurementResultFieldPlaceId, isEqualTo: placeId)
            .orderBy(wifiMeasurementResultFieldCreatedAt, descending: true)
        : collectionRef
            .where(wifiMeasurementResultFieldPlaceId, isEqualTo: placeId)
            .orderBy(wifiMeasurementResultFieldCreatedAt, descending: true)
            .limit(3);
    final snapshot = await query.get();
    return snapshot.docs.map((event) => event.data()).toList();
  }
}
