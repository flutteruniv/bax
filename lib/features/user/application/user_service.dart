import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/data/firebase_auth.dart';
import '../data/user_repository.dart';
import '../domain/user.dart';

final currentUserProvider = FutureProvider(
  (ref) async {
    return ref.watch(userServiceProvider).getUser();
  },
);

final userServiceProvider = Provider((ref) {
  return UserService(ref);
});

class UserService {
  UserService(this.ref);

  final Ref ref;

  Future<User?> getUser() async {
    final uid = ref.watch(firebaseAuthProvider).currentUser?.uid;
    if (uid == null) {
      return null;
    }
    final userRepository = ref.watch(userRepositoryProvider);
    return userRepository.getUser(uid);
  }
}
