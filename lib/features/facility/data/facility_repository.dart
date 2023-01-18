import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

import '../../../configs/firebase.dart';
import '../../../configs/logger.dart';
import '../domain/facility.dart';

final facilityRepositoryProvider = Provider(
  (ref) => FacilityRepository(
    firestore: ref.watch(firebaseFirestoreProvider),
  ),
);

final facilitiesStreamProvider = StreamProvider(
  (ref) {
    return ref.watch(facilityRepositoryProvider).facilitiesStream();
  },
);

class FacilityRepository {
  FacilityRepository({
    required this.firestore,
  });

  Stream<List<QueryDocumentSnapshot<Facility>>> facilitiesStream() {
    return _facilityCollectionReference.snapshots().map((event) => event.docs);
  }

  Future<Facility?> fetchFacility(String facilityId) async {
    final query = _facilityCollectionReference.where(facilityFieldId, isEqualTo: facilityId);
    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return snapshot.docs.first.data();
  }

  final FirebaseFirestore firestore;

  static const facilityCollectionName = 'facility';
  static const facilityFieldId = 'id';

  CollectionReference<Facility> get _facilityCollectionReference =>
      firestore.collection(facilityCollectionName).withConverter<Facility>(
        fromFirestore: (snapshot, options) {
          final json = snapshot.data();
          return Facility.fromJson(json!);
        },
        toFirestore: (snapshot, options) {
          return snapshot.toJson();
        },
      );

  Future<void> saveFacility(
    String placeId,
    String facilityName,
    double latitude,
    double longitude,
    String address,
    double downloadSpeed,
    double uploadSpeed,
  ) async {
    final docRef = firestore.collection(facilityCollectionName).doc(placeId);
    try {
      await docRef.set(
        Facility(
          id: placeId,
          name: facilityName,
          geo: GeoFirePoint(latitude, longitude),
          address: address,
          downloadSpeed: downloadSpeed,
          uploadSpeed: uploadSpeed,
          docRef: docRef,
        ).toJson(),
      );
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
