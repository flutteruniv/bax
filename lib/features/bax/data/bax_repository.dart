import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/firebase.dart';
import '../domain/bax.dart';

final baxRepositoryProvider = Provider(
  (ref) => BaxRepository(
    firestore: ref.watch(firebaseFirestoreProvider),
  ),
);

class BaxRepository {
  BaxRepository({required this.firestore});

  final FirebaseFirestore firestore;

  static const baxCollectionName = 'bax';
  static const baxFieldUid = 'uid';

  /// Bax履歴を取得する
  Future<List<Bax>> getBaxHistories(String uid) async {
    final query = _baxCollectionReference.where(baxFieldUid, isEqualTo: uid);
    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return [];
    }
    return snapshot.docs.map((snapshot) => snapshot.data()).toList();
  }

  CollectionReference<Bax> get _baxCollectionReference => firestore.collection(baxCollectionName).withConverter<Bax>(
        fromFirestore: (snapshot, options) {
          final json = snapshot.data();
          return Bax.fromJson(json!);
        },
        toFirestore: (snapshot, options) {
          return snapshot.toJson();
        },
      );
}
