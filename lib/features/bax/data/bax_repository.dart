import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/firebase.dart';
import '../../../configs/logger.dart';
import '../../user/domain/user.dart';
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
  static const userCollectionName = 'user';

  /// BAX付与する
  Future<void> giveBax(String uid, Bax bax) async {
    var totalBax = 0.0;
    for (final baxReason in bax.baxReasons) {
      totalBax = baxReason.point * bax.bonusRate;
    }

    final batch = firestore.batch();
    final baxDocRef = firestore.collection(baxCollectionName).doc();
    final userDocRef = firestore.collection(userCollectionName).doc(uid);

    try {
      /// Bax付与履歴への追加とUserへのBax付与をBatch処理で行う
      batch
        ..set(baxDocRef, bax.toJson())
        ..set(userDocRef, User(uid: uid, totalBax: totalBax).toJson());
      await batch.commit();
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
