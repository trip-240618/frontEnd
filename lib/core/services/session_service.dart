import 'package:tripStory/core/services/login_user_service.dart';
import 'package:tripStory/data/datasources/local/token_storage.dart';

class SessionService {
  final TokenStorage _tokenStorage;
  final LoginUserService _loginUserService;

  SessionService(
    this._tokenStorage,
    this._loginUserService,
  );

  Future<void> saveTokens(
    String accessToken,
    String refreshToken,
  ) async {
    await _tokenStorage.saveTokens(accessToken, refreshToken);
  }

  Future<Map<String, String>> getTokens() async {
    return await _tokenStorage.getTokens();
  }

  Future<void> clearSession() async {
    await _tokenStorage.clear();
    _loginUserService.clearUser();
  }
}
