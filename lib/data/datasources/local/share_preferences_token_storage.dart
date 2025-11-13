import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripStory/data/datasources/local/token_storage.dart';

class SharedPreferencesTokenStorage implements TokenStorage {
  static const String _accessKey = "accessToken";
  static const String _refreshKey = "refreshToken";
  static const String _cfPolicyKey = "CloudFront-Policy";
  static const String _cfSignatureKey = "CloudFront-Signature";
  static const String _cfKeyPairIdKey = "CloudFront-Key-Pair-Id";
  static const String _skippedVersionKey = "skippedVersion";

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

  @override
  Future<void> saveCloudFrontCookies({
    required String policy,
    required String signature,
    required String keyPairId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cfPolicyKey, policy);
    await prefs.setString(_cfSignatureKey, signature);
    await prefs.setString(_cfKeyPairIdKey, keyPairId);
  }

  @override
  Future<Map<String, String>> getCloudFrontCookies() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'CloudFront-Policy': prefs.getString(_cfPolicyKey) ?? "",
      'CloudFront-Signature': prefs.getString(_cfSignatureKey) ?? "",
      'CloudFront-Key-Pair-Id': prefs.getString(_cfKeyPairIdKey) ?? "",
    };
  }

  @override
  Future<void> saveSkippedVersion(String version) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_skippedVersionKey, version);
  }

  @override
  Future<String?> getSkippedVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_skippedVersionKey);
  }
}
