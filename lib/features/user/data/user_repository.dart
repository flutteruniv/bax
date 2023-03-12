import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/firebase.dart';
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
}
