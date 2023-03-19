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
  static const userFieldBaxPoint = 'baxPoint';

  static const baxCollectionName = 'bax';

  /// User情報を取得する
  Future<User?> getUser(String uid) async {
    final query = firestore.collection(userCollectionName).doc(uid).withConverter<User?>(
      fromFirestore: (snapshot, options) {
        final json = snapshot.data();
        if (json == null) {
          return null;
        }
        return User.fromJson(json);
      },
      toFirestore: (snapshot, options) {
        return snapshot!.toJson();
      },
    );
    final snapshot = await query.get();
    return snapshot.data();
  }

  /// BAXを付与する
  Future<void> giveBax(String uid, Bax bax) async {
    final batch = firestore.batch();
    final baxDocRef = firestore.collection(baxCollectionName).doc();
    final userDocRef = firestore.collection(userCollectionName).doc(uid);

    try {
      /// Bax付与履歴への追加とUserへのBax付与をBatch処理で行う
      batch
        ..set(baxDocRef, bax.toJson())
        ..set(
          userDocRef,
          {userFieldTotalBax: FieldValue.increment(totalBaxPoint)},
          SetOptions(merge: true),
        );
      await batch.commit();
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
