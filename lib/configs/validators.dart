import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/load/application/scaffold_manager_key.dart';
import 'localizations.dart';

final validatorsProvider = Provider((ref) {
  return Validators(ref);
});

class Validators {
  Validators(this.ref);
  final Ref ref;

  AppLocalizations get l => ref.read(localizationsProvider);

  static const emailFormat = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";

  bool validEmail(String email) {
    if (email.isEmpty) {
      ref.watch(snackBarServiceProvider).showSnackBar(l.enterEmail);
      return false;
    }
    if (!RegExp(emailFormat, caseSensitive: false).hasMatch(email)) {
      ref.watch(snackBarServiceProvider).showSnackBar(l.invalidEmail);
      return false;
    }
    return true;
  }
}
