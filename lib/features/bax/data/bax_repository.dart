import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/firebase.dart';
import '../../../configs/logger.dart';
import '../domain/bax.dart';

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

  /// BAX付与履歴に追加する
  Future<void> addBax(String uid, Bax bax) async {
    final docRef = firestore.collection(baxCollectionName).doc();

    try {
      await docRef.set(
        bax.toJson(),
      );
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
