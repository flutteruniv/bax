import 'dart:async';

import 'package:bax/configs/firebase.dart';
import 'package:bax/features/facility/domain/facility.dart';
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

  final FirebaseFirestore firestore;

  static const facilityCollectionName = 'facility';

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
