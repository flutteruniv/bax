import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/firebase.dart';
import '../domain/bax.dart';

final baxRepositoryProvider = Provider(
  (ref) => BaxRepository(
    firestore: ref.watch(firebaseFirestoreProvider),
  ),
);

final baxHistoriesProvider = StreamProvider.family((ref, String? uid) {
  return ref.read(baxRepositoryProvider).streamBaxHistories(uid);
});

class BaxRepository {
  BaxRepository({required this.firestore});

  final FirebaseFirestore firestore;

  static const baxCollectionName = 'bax';
  static const baxFieldUid = 'uid';

  /// Bax履歴を取得する
  Stream<QuerySnapshot<Bax>> streamBaxHistories(String? uid) {
    final query = _baxCollectionReference.where(baxFieldUid, isEqualTo: uid);
    return query.snapshots();
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
