import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/controller/userState.dart';
import '../api/userApi.dart';

/// 카카오로그인
Future<void> kakaoLogin() async {
  if (await isKakaoTalkInstalled()) {
    print('카카오톡 설치');
    try {
      final oauthToken= await UserApi.instance.loginWithKakaoTalk();
      await sendTokenToServer(oauthToken.accessToken,oauthToken.refreshToken.toString());
      await requestUserInfo();
    } catch (error) {
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      /// 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        await UserApi.instance.loginWithKakaoAccount();
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공');
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}
Future<void> requestUserInfo() async {
  User user;
  try {
    user = await UserApi.instance.me();
  } catch (error) {
    print('사용자 정보 요청 실패 $error');
    return;
  }
  /// 사용자의 추가 동의가 필요한 사용자 정보 동의항목 확인
  List<String> scopes = [];

  if (user.kakaoAccount?.emailNeedsAgreement == true) {
    scopes.add('account_email');
  }
  if (user.kakaoAccount?.birthdayNeedsAgreement == true) {
    scopes.add("birthday");
  }
  if (user.kakaoAccount?.birthyearNeedsAgreement == true) {
    scopes.add("birthyear");
  }
  if (user.kakaoAccount?.ciNeedsAgreement == true) {
    scopes.add("account_ci");
  }
  if (user.kakaoAccount?.phoneNumberNeedsAgreement == true) {
    scopes.add("phone_number");
  }
  if (user.kakaoAccount?.profileNeedsAgreement == true) {
    scopes.add("profile");
  }
  if (user.kakaoAccount?.ageRangeNeedsAgreement == true) {
    scopes.add("age_range");
  }

  if (scopes.length > 0) {
    print('사용자에게 추가 동의 받아야 하는 항목이 있습니다');

    OAuthToken token;
    try {
      token = await UserApi.instance.loginWithNewScopes(scopes);
      print('현재 사용자가 동의한 동의항목: ${token.scopes}');
    } catch (error) {
      print('추가 동의 요청 실패 $error');
      return;
    }
    /// 사용자 정보 재요청
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '??? : ${user}'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }
}
Future<void> sendTokenToServer(String accessToken,String refreshToken) async {
  final us = Get.put(UserState());
  final dioClient = DioClient();
  /// 백엔드 서버로 토큰 전송
  var response = await http.get(
    Uri.parse('https://trip-story.site/user/oauth2/callback/kakao?kakaoToken=${accessToken}&fcmToken=abcd')
  );
  if (response.statusCode == 200) {
    await dioClient.loginCookies('${response.headers['set-cookie']}');
    var decodedBody = utf8.decode(response.bodyBytes);
    var jsonResponse = jsonDecode(decodedBody);
    us.userList.value = [jsonResponse];
    // print('us???? ${jsonResponse}');
  } else {
    print('서버에 토큰 전송 실패: ${response.statusCode}');
  }
}

// /// 구글 로그인 서버로 데이터
// Future<void> googleSendData(GoogleSignInAccount user) async {
//   final dioClient = DioClient();
//   final apiUserClient = ApiUserClient(dioClient);
//   final url = 'https://trip-story.site/user/oauth2/login/google';
//   final userData = {
//     "displayName": user.displayName,
//     "email": user.email,
//     "id": user.id,
//     "photoUrl": user.photoUrl,
//     "serverAuthCode": user.serverAuthCode,
//   };
//   final response = await httpClient.post(
//     Uri.parse(url),
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode(userData),
//   );
//   await saveCookies('${response.headers['set-cookie']}');
//   print('gogole data ? ${response.body}');
//   print('Google login data sent successfully');
// }
// /// 애플 로그인 서버로 데이터
// Future<void> appleSendData(AuthorizationCredentialAppleID user) async {
//   final url = 'https://trip-story.site/user/oauth2/login/apple';
//   final body = {
//     "email":'${user.email}',
//     "displayName": "${user.authorizationCode}",
//     "familyName": "${user.familyName}",
//     "givenName": "${user.givenName}",
//     "identityToken": "${user.identityToken}",
//     "state":"${user.state}",
//     "userIdentifier": "${user.userIdentifier}"
//   };
//   final response = await httpClient.post(
//     Uri.parse(url),
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode(body),
//   );
//   await saveCookies('${response.headers['set-cookie']}');
//   print('apple data ? ${response.body}');
//   print('apple login data sent successfully');
// }