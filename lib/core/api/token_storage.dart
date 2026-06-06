import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kTokenKey = 'va_auth_token';

@Singleton()
class TokenStorage {
  final SharedPreferences _prefs;
  TokenStorage(this._prefs);

  String? get token => _prefs.getString(_kTokenKey);
  bool get hasToken => token != null;

  Future<void> save(String token) => _prefs.setString(_kTokenKey, token);
  Future<void> clear() => _prefs.remove(_kTokenKey);
}
