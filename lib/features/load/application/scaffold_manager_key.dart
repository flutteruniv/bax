import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scaffoldMessengerKeyProvider = Provider(
  (_) => GlobalKey<ScaffoldMessengerState>(),
);

/// SnackBarを出すためのサービスクラス
final snackBarServiceProvider = Provider((ref) {
  final scaffoldMessengerKey = ref.watch(scaffoldMessengerKeyProvider);
  return SnackBarService(scaffoldMessengerKey);
});

class SnackBarService {
  SnackBarService(this.globalKey);

  final GlobalKey<ScaffoldMessengerState> globalKey;

  void showSnackBar(String text) {
    globalKey.currentState?.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(text),
      ),
    );
  }
}
