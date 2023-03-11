import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/firebase.dart';
import '../../../configs/logger.dart';
import '../domain/bax.dart';
import '../domain/bax_reasons.dart';

final baxRepositoryProvider = Provider(
  (ref) => BaxRepository(
    firestore: ref.watch(firebaseFirestoreProvider),
  ),
);

class BaxRepository {
  BaxRepository({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  static const baxCollectionName = 'bax';

  Future<void> giveBax(String uid) async {
    final docRef = firestore.collection(baxCollectionName).doc();

    try {
      await docRef.set(
        Bax(
          uid: uid,
          bonusRate: 1,
          baxReasons: [BaxReasons.measurementWifi],
        ).toJson(),
      );
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
