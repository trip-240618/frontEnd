import 'dart:convert';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class ApiUserClient {
  final http.Client httpClient;

  ApiUserClient({http.Client? httpClient}) : httpClient = httpClient ?? http.Client();

  /// 서버에 토큰 보냄
  Future<void> sendTokenToServer(String accessToken, String refreshToken) async {
    /// 백엔드 서버로 토큰 전송
    var response = await httpClient.get(
      Uri.parse('https://trip-story.site/user/oauth2/callback/kakao?token=$accessToken'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 200) {
      var response2 = await httpClient.get(
        Uri.parse('https://trip-story.site/hc'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': '${response.headers['set-cookie']}',
        },
      );
      await saveCookies('${response.headers['set-cookie']}');
    } else {
      print('서버에 토큰 전송 실패: ${response.statusCode}');
    }
  }

  /// 구글 로그인 서버로 데이터
  Future<void> googleSendData(GoogleSignInAccount user) async {
    final url = 'https://trip-story.site/user/oauth2/login/google';
    final userData = {
      "displayName": user.displayName,
      "email": user.email,
      "id": user.id,
      "photoUrl": user.photoUrl,
      "serverAuthCode": user.serverAuthCode,
    };
    final response = await httpClient.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );
    await saveCookies('${response.headers['set-cookie']}');
    print('gogole data ? ${response.body}');
    print('Google login data sent successfully');
  }
  /// 애플 로그인 서버로 데이터
  Future<void> appleSendData(AuthorizationCredentialAppleID user) async {
    final url = 'https://trip-story.site/user/oauth2/login/apple';
    final body = {
      "email":'${user.email}',
      "displayName": "${user.authorizationCode}",
      "familyName": "${user.familyName}",
      "givenName": "${user.givenName}",
      "identityToken": "${user.identityToken}",
      "state":"${user.state}",
      "userIdentifier": "${user.userIdentifier}"
    };
    final response = await httpClient.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    await saveCookies('${response.headers['set-cookie']}');
    print('apple data ? ${response.body}');
    print('apple login data sent successfully');
  }
  /// 자동 로그인
  Future<List> autoLogin(String cookies) async {
    var response = await httpClient.get(
      Uri.parse('https://trip-story.site/user/info'),
      headers: {
        'Cookie': cookies,
      },
    );
    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      final List<dynamic> data = [jsonDecode(responseBody)];
      // final List<dynamic> data = [jsonDecode(response.body.)];
      // 데이터 반환
      return data;
    } else {
      throw Exception('Failed to auto-login: ${response.body}');
    }
  }
  /// 쿠키 저장
  Future<void> saveCookies(String cookies) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cookies', cookies);
  }
  ///쿠키 가져오기
  Future<String?> getCookies() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cookies');
  }
}
