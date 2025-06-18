import 'package:shared_preferences/shared_preferences.dart';

import 'token_storage.dart';

class SharedPreferencesTokenStorage implements TokenStorage {
  static const String _accessKey = "accessToken";
  static const String _refreshKey = "refreshToken";

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessKey, accessToken);
    await prefs.setString(_refreshKey, refreshToken);
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessKey, accessToken);
  }

  @override
  Future<Map<String, String>> getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      _accessKey: prefs.getString(_accessKey) ?? "",
      _refreshKey: prefs.getString(_refreshKey) ?? "",
    };
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessKey);
    await prefs.remove(_refreshKey);
  }
}
