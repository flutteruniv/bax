import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

final nowVersionProvider = FutureProvider((ref) {
  return ref.watch(updateRepositoryProvider).nowVersion();
});

class UpdateRepository {
  UpdateRepository({
    required this.firestore,
  });

  Future<String> nowVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  final FirebaseFirestore firestore;
  static const updateCollectionName = 'config';
  static const minimumVersionDocId = 'v1';

  Stream<DocumentSnapshot<Map<String, dynamic>>> updateStream() {
    return _updateCollectionReference.snapshots();
  }

  DocumentReference<Map<String, dynamic>> get _updateCollectionReference =>
      firestore.collection(updateCollectionName).doc(minimumVersionDocId);
}
