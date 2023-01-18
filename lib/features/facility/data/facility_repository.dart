import 'dart:async';

import 'package:bax/configs/firebase.dart';
import 'package:bax/features/facility/domain/facility.dart';
import 'package:bax/features/map/domain/geometry/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future<Location?> fetchLocation(String facilityId) async {
    final query = _facilityCollectionReference.where(facilityFieldId, isEqualTo: facilityId);
    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return null;
    }
    final data = snapshot.docs.first.data();
    return Location(latitude: data.geo.latitude, longitude: data.geo.longitude);
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
}
