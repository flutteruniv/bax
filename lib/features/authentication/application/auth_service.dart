import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/logger.dart';
import '../../../configs/preferences.dart';
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

/// メール送信が完了済であるかどうかのフラグを返すStreamProvider
final isSentMailStreamProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(authServiceProvider).isSentMailStream();
});

final authServiceProvider = Provider((ref) {
  return AuthService(ref);
});

class AuthService {
  AuthService(this.ref);
  final Ref ref;

  final _isSentMailController = StreamController<bool>();

  Stream<bool> isSentMailStream() {
    return _isSentMailController.stream;
  }

  final actionCodeSettings = ActionCodeSettings(
    // メールに埋め込むディープリンク。端末にアプリがインストールされていない場合にこのURLにリダイレクトされる
    url: 'https://com.flutteruniv.bax.dev', // TODO: 適切なURLを設定する
    handleCodeInApp: true, // リンクがモバイルで開かれる場合はtrueを指定
    iOSBundleId: 'com.flutteruniv.bax.dev',
    androidPackageName: 'com.flutteruniv.bax.dev',
    // アプリのインストールを自動的に促すかどうか
    androidInstallApp: true,
    androidMinimumVersion: '5.1',
  );

  /// 匿名ログイン
  Future<void> anonymousLogin() async {
    ref.read(loadingProvider.notifier).show();
    await ref.read(firebaseAuthProvider).signInAnonymously();
    ref.read(loadingProvider.notifier).hide();
    ref.read(snackBarServiceProvider).showSnackBar('ログインしました');
  }

  /// 指定のアドレスに認証メールを送る
  Future<void> sendMail(String email) async {
    try {
      await ref.read(firebaseAuthProvider).sendSignInLinkToEmail(email: email, actionCodeSettings: actionCodeSettings);
      await ref.watch(preferencesProvider).setEmail(email);
      _isSentMailController.add(true);
    } on FirebaseAuthException catch (e) {
      logger.e('メール送信エラー: $e');
      ref.read(snackBarServiceProvider).showSnackBar('メールの送信に失敗しました');
    }
  }

  /// アノニマスでログインしている現在のアカウントと、メールアドレスを紐付けさせる
  Future<void> authenticateMail(String emailLink) async {
    final pref = ref.watch(preferencesProvider);
    final authCredential = EmailAuthProvider.credentialWithLink(
      email: pref.getEmail(),
      emailLink: emailLink,
    );

    try {
      await ref.watch(firebaseAuthProvider).currentUser?.linkWithCredential(authCredential);
      await pref.removeEmail(); // アカウント紐付け後は保持しておく必要がないのでローカルから削除する
    } on FirebaseAuthException catch (e) {
      logger.e('メール認証エラー: $e');
    }
  }
}
