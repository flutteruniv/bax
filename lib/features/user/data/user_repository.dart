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

  /// Baxを付与する
  Future<void> giveBax(String uid, Bax bax) async {
    var totalBax = 0.0;
    for (final baxReason in bax.baxReasons) {
      totalBax = baxReason.point * bax.bonusRate;
    }

    final docRef = firestore.collection(userCollectionName).doc(uid);
    try {
      await docRef.set(
        User(uid: uid, totalBax: totalBax).toJson(),
      );
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
