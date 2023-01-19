import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../load/application/loading_notifier.dart';
import '../../load/application/scaffold_manager_key.dart';
import '../data/firebase_auth.dart';

/// 読み込み中の場合はnull
/// ログイン中であれば true そうでなければ false を返す
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authStateChanges = ref.watch(authStateChangesProvider);
  return authStateChanges.value != null;
});

final authStateChangesProvider = StreamProvider((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return firebaseAuth.authStateChanges();
});

final authServiceProvider = Provider((ref) {
  return AuthService(ref);
});

class AuthService {
  AuthService(this.ref);
  final Ref ref;

  /// 匿名ログイン
  Future<void> anonymousLogin() async {
    ref.read(loadingProvider.notifier).show();
    await ref.read(firebaseAuthProvider).signInAnonymously();
    ref.read(loadingProvider.notifier).hide();
    ref.read(snackBarServiceProvider).showSnackBar('ログインしました');
  }
}
