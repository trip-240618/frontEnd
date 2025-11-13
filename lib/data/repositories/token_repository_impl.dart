import 'package:tripStory/data/datasources/local/token_storage.dart';
import 'package:tripStory/domain/repositories/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenStorage _storage;

  TokenRepositoryImpl(this._storage);

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) => _storage.saveTokens(accessToken, refreshToken);

  @override
  Future<void> saveAccessToken(String accessToken) => _storage.saveAccessToken(accessToken);

  @override
  Future<Map<String, String>> getTokens() => _storage.getTokens();

  @override
  Future<void> clear() => _storage.clear();

  @override
  Future<void> saveCloudFrontCookies({
    required String policy,
    required String signature,
    required String keyPairId,
  }) =>
      _storage.saveCloudFrontCookies(
        policy: policy,
        signature: signature,
        keyPairId: keyPairId,
      );

  @override
  Future<Map<String, String>> getCloudFrontCookies() => _storage.getCloudFrontCookies();

  @override
  Future<void> saveSkippedVersion(String version) => _storage.saveSkippedVersion(version);

  @override
  Future<String?> getSkippedVersion() => _storage.getSkippedVersion();
}
