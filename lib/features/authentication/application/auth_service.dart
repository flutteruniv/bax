import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/environment.dart';
import '../../../configs/localizations.dart';
import '../../../configs/logger.dart';
import '../../../configs/preferences.dart';
import '../../../configs/validators.dart';
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

final uidProvider = Provider((ref) => ref.watch(authStateChangesProvider).valueOrNull?.uid);

/// メール送信が完了済であるかどうかのフラグを返すStreamProvider
final isSentEmailStreamProvider = StreamProvider((ref) {
  return ref.watch(authServiceProvider).isSentEmailStream();
});

final authServiceProvider = Provider((ref) {
  return AuthService(ref);
});

class AuthService {
  AuthService(this.ref);
  final Ref ref;

  AppLocalizations get l => ref.read(localizationsProvider);

  final _isSentEmailController = StreamController<bool>();

  Stream<bool> isSentEmailStream() {
    return _isSentEmailController.stream;
  }

  final actionCodeSettings = ActionCodeSettings(
    // メールに埋め込むディープリンク。端末にアプリがインストールされていない場合にこのURLにリダイレクトされる
    url: 'https://bax.network',
    handleCodeInApp: true, // リンクがモバイルで開かれる場合はtrueを指定
    iOSBundleId: isDevEnvironment() ? 'com.flutteruniv.bax.dev' : 'com.flutteruniv.bax',
    androidPackageName: isDevEnvironment() ? 'com.flutteruniv.bax.dev' : 'com.flutteruniv.bax',
    // アプリのインストールを自動的に促すかどうか
    androidInstallApp: true,
    androidMinimumVersion: '5.1',
  );

  /// 匿名ログイン
  Future<void> anonymousLogin() async {
    ref.read(loadingProvider.notifier).show();
    await ref.read(firebaseAuthProvider).signInAnonymously();
    ref.read(loadingProvider.notifier).hide();
    ref.read(snackBarServiceProvider).showSnackBar(l.loggedIn);
  }

  Future<void> logout() async {
    await ref.read(firebaseAuthProvider).signOut();
  }

  /// 指定のアドレスに認証メールを送る
  Future<void> sendEmail(String email) async {
    final isValidEmail = ref.watch(validatorsProvider).validEmail(email);
    if (!isValidEmail) {
      return;
    }

    try {
      /// TODO: 一定時間かかるのでローディング表示したい
      await ref.watch(firebaseAuthProvider).sendSignInLinkToEmail(email: email, actionCodeSettings: actionCodeSettings);
      await ref.watch(preferencesProvider).setEmail(email);
      _isSentEmailController.add(true);
    } on FirebaseAuthException catch (e) {
      logger.e('メール送信エラー: $e');
      switch (e.code) {
        case 'invalid-email':
          ref.watch(snackBarServiceProvider).showSnackBar(l.invalidEmail);
        default:
          ref.watch(snackBarServiceProvider).showSnackBar(l.emailSendFailed);
          break;
      }
    }
  }

  /// アノニマスでログインしている現在のアカウントと、メールアドレスを紐付けさせる
  Future<void> linkWithCredentialByEmailLink(String emailLink) async {
    final pref = ref.watch(preferencesProvider);
    final authCredential = EmailAuthProvider.credentialWithLink(
      email: pref.getEmail(),
      emailLink: emailLink,
    );
    try {
      await ref.watch(firebaseAuthProvider).currentUser?.linkWithCredential(authCredential);
      await pref.removeEmail(); // アカウント紐付け後は保持しておく必要がないのでローカルから削除する
      ref.watch(snackBarServiceProvider).showSnackBar(l.emailVerified);
    } on FirebaseAuthException catch (e) {
      logger.e('メール認証エラー: $e');
      switch (e.code) {
        case 'provider-already-linked':
          ref.watch(snackBarServiceProvider).showSnackBar(l.emailAlreadyVerified);
        case 'email-already-in-use':
          ref.watch(snackBarServiceProvider).showSnackBar(l.emailAlreadyInUse);
        default:
          ref.watch(snackBarServiceProvider).showSnackBar(l.emailVerificationFailed);
          break;
      }
    }
  }

  /// メールアドレスでログイン
  Future<void> signWithCredentialByEmailLink(String emailLink) async {
    final pref = ref.watch(preferencesProvider);
    final authCredential = EmailAuthProvider.credentialWithLink(
      email: pref.getEmail(),
      emailLink: emailLink,
    );
    try {
      await ref.watch(firebaseAuthProvider).signInWithCredential(authCredential);
      await pref.removeEmail(); // アカウント紐付け後は保持しておく必要がないのでローカルから削除する
      ref.watch(snackBarServiceProvider).showSnackBar(l.emailVerified);
    } on FirebaseAuthException catch (e) {
      logger.e('メール認証エラー: $e');
      switch (e.code) {
        case 'provider-already-linked':
          ref.watch(snackBarServiceProvider).showSnackBar(l.emailAlreadyVerified);
        case 'email-already-in-use':
          ref.watch(snackBarServiceProvider).showSnackBar(l.emailAlreadyInUse);
        default:
          ref.watch(snackBarServiceProvider).showSnackBar(l.emailVerificationFailed);
          break;
      }
    }
  }

  void resetEmailSetting() {
    _isSentEmailController.add(false);
  }
}
