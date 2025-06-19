abstract class TokenStorage {
  Future<void> saveTokens(String accessToken, String refreshToken);

  Future<void> saveAccessToken(String accessToken);

  Future<Map<String, String>> getTokens();

  Future<void> clear();
}
