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

class FacilityRepository {
  FacilityRepository({
    required this.firestore,
  });

  final FirebaseFirestore firestore;
  final _facilityChangesController = StreamController<List<Facility>>.broadcast();

  static const facilityCollectionName = 'facility';

  void dispose() {
    _facilityChangesController.close();
  }

  Stream<List<Facility>> changesFacilities() => _facilityChangesController.stream;

  Future<List<Facility>> fetchFacilities() async {
    final query = firestore.collection(facilityCollectionName).withFacilityConverter();
    final snapshot = await query.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  void updateFacilities(List<Facility> facilities) {
    _facilityChangesController.add(facilities);
  }
}

extension _CollectionReferenceEx on CollectionReference<Map<String, dynamic>> {
  CollectionReference<Facility> withFacilityConverter() => withConverter(
        fromFirestore: (snapshot, options) {
          final json = snapshot.data();
          return Facility.fromJson(json!);
        },
        toFirestore: (snapshot, options) {
          return snapshot.toJson();
        },
      );
}