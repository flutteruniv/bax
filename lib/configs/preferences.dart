import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preferencesProvider = Provider((ref) {
  return Preferences()..init();
});

class Preferences {
  Preferences();

  late SharedPreferences _pref;

  static const keyEmail = 'email';

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<void> setEmail(String email) async {
    await _pref.setString(keyEmail, email);
  }

  String getEmail() {
    return _pref.getString(keyEmail) ?? '';
  }

  Future<void> removeEmail() async {
    await _pref.remove(keyEmail);
  }
}
