import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/firebase.dart';
import '../../../configs/logger.dart';
import '../../bax/domain/bax.dart';
import '../domain/user.dart';

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
  static const userFieldUid = 'uid';

  static const baxCollectionName = 'bax';

  /// 現在のBaxを取得する
  Future<double> fetchBaxPoint(String uid) async {
    final query = firestore.collection(userCollectionName).doc(uid).withConverter<User>(
      fromFirestore: (snapshot, options) {
        final json = snapshot.data();
        return User.fromJson(json!);
      },
      toFirestore: (snapshot, options) {
        return snapshot.toJson();
      },
    );
    final snapshot = await query.get();
    return snapshot.data()?.totalBax ?? 0.0;
  }

  /// BAXを付与する
  Future<void> giveBax(String uid, Bax bax, double currentBaxPoint) async {
    var totalBaxPoint = currentBaxPoint;
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
        ..set(userDocRef, User(uid: uid, totalBax: totalBaxPoint).toJson());
      await batch.commit();
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
