import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/load/application/scaffold_manager_key.dart';

final validatorsProvider = Provider((ref) {
  return Validators(ref);
});

class Validators {
  Validators(this.ref);
  final Ref ref;

  static const emailFormat = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";

  bool validEmail(String email) {
    if (email.isEmpty) {
      ref.watch(snackBarServiceProvider).showSnackBar('メールアドレスを入力してください');
      return false;
    }
    if (!RegExp(emailFormat, caseSensitive: false).hasMatch(email)) {
      ref.watch(snackBarServiceProvider).showSnackBar('メールアドレスが無効な形式です');
      return false;
    }
    return true;
  }
}
