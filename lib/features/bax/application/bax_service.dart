import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/logger.dart';
import '../../authentication/data/firebase_auth.dart';
import '../data/Bax_repository.dart';
import '../domain/bax.dart';

final baxHistoriesProvider = FutureProvider.autoDispose(
  (ref) async {
    return ref.watch(baxServiceProvider).getBaxHistories();
  },
);

final baxServiceProvider = Provider((ref) {
  return BaxService(ref);
});

class BaxService {
  BaxService(this.ref);

  final Ref ref;

  Future<List<Bax>> getBaxHistories() async {
    final uid = ref.watch(firebaseAuthProvider).currentUser?.uid;
    if (uid == null) {
      logger.e('uid is null.');
      return [];
    }
    final baxRepository = ref.watch(baxRepositoryProvider);
    return baxRepository.getBaxHistory(uid);
  }
}
