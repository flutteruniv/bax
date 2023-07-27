import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preferencesProvider = Provider<Preferences>((ref) {
  throw Exception();
});

class Preferences {
  Preferences(this._pref);

  final SharedPreferences _pref;

  static const keyEmail = 'email';

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
