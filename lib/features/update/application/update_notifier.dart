import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/firebase.dart';

final updateRepositoryProvider = Provider(
  (ref) => UpdateRepository(
    firestore: ref.watch(firebaseFirestoreProvider),
  ),
);

final updateStreamProvider = StreamProvider(
  (ref) {
    return ref.watch(updateRepositoryProvider).updateStream();
  },
);

class UpdateRepository {
  UpdateRepository({
    required this.firestore,
  });

  final FirebaseFirestore firestore;
  static const updateCollectionName = 'config';
  static const minimumVersionDocId = 'v1';

    Stream<DocumentSnapshot<Map<String, dynamic>>> updateStream() {
    return _updateCollectionReference.snapshots();
  }

  DocumentReference<Map<String, dynamic>> get _updateCollectionReference =>
      firestore.collection(updateCollectionName).doc(minimumVersionDocId);
}
