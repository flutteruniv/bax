import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/firebase.dart';
import '../../../configs/logger.dart';
import '../../bax/domain/bax.dart';

final userRepositoryProvider = Provider(
  (ref) => UserRepository(
    firestore: ref.watch(firebaseFirestoreProvider),
  ),
);

class UserRepository {
  UserRepository({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  static const userCollectionName = 'user';
  static const userFieldTotalBax = 'totalBax';

  static const baxCollectionName = 'bax';

  /// BAXを付与する
  Future<void> giveBax(String uid, Bax bax) async {
    var totalBaxPoint = 0.0;
    for (final baxReason in bax.baxReasons) {
      totalBaxPoint += baxReason.point * bax.bonusRate;
    }

    final batch = firestore.batch();
    final baxDocRef = firestore.collection(baxCollectionName).doc();
    final userDocRef = firestore.collection(userCollectionName).doc(uid);

    try {
      /// Bax付与履歴への追加とUserへのBax付与をBatch処理で行う
      batch
        ..set(baxDocRef, bax.toJson())
        ..update(userDocRef, {userFieldTotalBax: FieldValue.increment(totalBaxPoint)});
      await batch.commit();
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
