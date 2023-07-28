import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/firebase.dart';
import '../../../configs/logger.dart';
import '../../authentication/application/auth_service.dart';
import '../../bax/domain/bax.dart';
import '../domain/user.dart';

final userRepositoryProvider = Provider(
  (ref) => UserRepository(
    ref: ref,
    firestore: ref.watch(firebaseFirestoreProvider),
  ),
);

final userProvider = StreamProvider.family((ref, String uid) {
  return ref.read(userRepositoryProvider).streamUser(uid);
});

class UserRepository {
  UserRepository({
    required this.firestore,
    required this.ref,
  });

  final FirebaseFirestore firestore;
  final Ref ref;

  static const userCollectionName = 'user';
  static const userFieldUid = 'uid';
  static const userFieldBaxPoint = 'baxPoint';

  static const baxCollectionName = 'bax';

  /// User情報を取得する
  Stream<DocumentSnapshot<User?>> streamUser(String? uid) {
    return firestore.collection(userCollectionName).doc(uid).withConverter<User?>(
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
    ).snapshots();
  }

  /// BAXを付与する
  Future<void> giveBax(Bax bax) async {
    final uid = ref.read(uidProvider);
    if (uid == null) {
      return;
    }
    final batch = firestore.batch();
    final baxDocRef = firestore.collection(baxCollectionName).doc();
    final userDocRef = firestore.collection(userCollectionName).doc(uid);

    try {
      /// Bax付与履歴への追加とUserへのBax付与をBatch処理で行う
      batch
        ..set(baxDocRef, bax.toJson())
        ..set(
          userDocRef,
          {userFieldBaxPoint: FieldValue.increment(bax.totalPoint)},
          SetOptions(merge: true),
        );
      await batch.commit();
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
