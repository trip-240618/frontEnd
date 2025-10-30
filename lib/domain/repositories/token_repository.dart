abstract class TokenRepository {
  Future<void> saveTokens(String accessToken, String refreshToken);
  Future<void> saveAccessToken(String accessToken);
  Future<Map<String, String>> getTokens();
  Future<void> clear();

  Future<void> saveCloudFrontCookies({
    required String policy,
    required String signature,
    required String keyPairId,
  });

  Future<Map<String, String>> getCloudFrontCookies();

  Future<void> saveSkippedVersion(String version);
  Future<String?> getSkippedVersion();
}
