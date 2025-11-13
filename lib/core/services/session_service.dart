import 'package:tripStory/data/datasources/local/token_storage.dart';
import 'package:tripStory/presentation/global/login_user_service.dart';

class SessionService {
  final TokenStorage _tokenStorage;
  final LoginUserService _loginUserService;

  SessionService(
    this._tokenStorage,
    this._loginUserService,
  );

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _tokenStorage.saveTokens(accessToken, refreshToken);
  }

  Future<void> saveTokensWithCloudFront({
    required String policy,
    required String signature,
    required String keyPairId,
  }) async {
    await _tokenStorage.saveCloudFrontCookies(
      policy: policy,
      signature: signature,
      keyPairId: keyPairId,
    );
  }

  Future<Map<String, String>> getTokens() async {
    return await _tokenStorage.getTokens();
  }

  Future<void> clearSession() async {
    await _tokenStorage.clear();
    _loginUserService.clearUser();
  }

  Future<String> getCloudCookieHeader() async {
    final cookies = await _tokenStorage.getCloudFrontCookies();

    final cookieString = [
      if (cookies["CloudFront-Policy"]?.isNotEmpty == true) "CloudFront-Policy=${cookies['CloudFront-Policy']}",
      if (cookies["CloudFront-Signature"]?.isNotEmpty == true)
        "CloudFront-Signature=${cookies["CloudFront-Signature"]}",
      if (cookies["CloudFront-Key-Pair-Id"]?.isNotEmpty == true)
        "CloudFront-Key-Pair-Id=${cookies["CloudFront-Key-Pair-Id"]}",
    ].join('; ');

    return cookieString;
  }

  Future<void> handleSetCookieHeader(List<String> setCookieHeader) async {
    final cookies = _parseSetCookieHeader(setCookieHeader);

    final accessToken = cookies["accessToken"];
    final refreshToken = cookies["refreshToken"];
    final policy = cookies["CloudFront-Policy"];
    final signature = cookies["CloudFront-Signature"];
    final keyPairId = cookies["CloudFront-Key-Pair-Id"];

    if (accessToken != null && refreshToken != null) {
      await saveTokens(accessToken, refreshToken);
    } else if (accessToken != null) {
      final current = await getTokens();
      await saveTokens(accessToken, current["refreshToken"] ?? "");
    }

    if (policy != null && signature != null && keyPairId != null) {
      await saveTokensWithCloudFront(
        policy: policy,
        signature: signature,
        keyPairId: keyPairId,
      );
    }
  }

  Map<String, String> _parseSetCookieHeader(List<String> rawHeaders) {
    final Map<String, String> cookies = {};
    for (var raw in rawHeaders) {
      final parts = raw.split(";").first.trim().split("=");
      if (parts.length == 2) {
        cookies[parts[0].trim()] = parts[1].trim();
      }
    }
    return cookies;
  }
}
