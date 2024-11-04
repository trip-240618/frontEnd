import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/controller/userState.dart';
import '../api/userApi.dart';

/// 카카오로그인
Future<void> kakaoLogin() async {
  if (await isKakaoTalkInstalled()) {
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
        final oauthToken = await UserApi.instance.loginWithKakaoAccount();
        await sendTokenToServer(oauthToken.accessToken,oauthToken.refreshToken.toString());
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      final oauthToken = await UserApi.instance.loginWithKakaoAccount();
      await sendTokenToServer(oauthToken.accessToken,oauthToken.refreshToken.toString());
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
  String? tokens = await FirebaseMessaging.instance.getToken();
  print('?? tokesn??${tokens}');
  /// 백엔드 서버로 토큰 전송
  var response = await http.get(
    Uri.parse('https://trip-story.site/user/oauth2/callback/kakao?kakaoToken=${accessToken}&fcmToken=$tokens')
  );
  if (response.statusCode == 200) {
    await dioClient.loginCookies('${response.headers['set-cookie']}');
    var decodedBody = utf8.decode(response.bodyBytes);
    var jsonResponse = jsonDecode(decodedBody);
    us.userList.value = [jsonResponse];
  } else {
    print('서버에 토큰 전송 실패: ${response.statusCode}');
  }
}
/// 구글로그인
Future<void> googleLogin() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  try {
    await _googleSignIn.signIn().then((value)async{
      if(value!=null){
        await requestGoogleInfo(value);
      }
    });
  } catch (error) {
    print(error);
  }
}

/// 구글 로그인 서버로 데이터
Future<void> requestGoogleInfo(GoogleSignInAccount user) async {
  final us = Get.put(UserState());
  final dioClient = DioClient();
  String? tokens;
  if(Platform.isIOS){
    tokens = await FirebaseMessaging.instance.getAPNSToken();
    print('tokens?? ${tokens}');
  }else{
    tokens = await FirebaseMessaging.instance.getToken();
  }
  final url = 'https://trip-story.site/user/oauth2/login/google';
  print('tk?? ${tokens}');
  final userData = {
    "displayName": user.displayName,
    "email": user.email,
    "id": user.id,
    "photoUrl": user.photoUrl,
    "serverAuthCode": '',
    'fcmToken':tokens
  };
  var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData)
  );
  if (response.statusCode == 200) {
    await dioClient.loginCookies('${response.headers['set-cookie']}');
    var decodedBody = utf8.decode(response.bodyBytes);
    var jsonResponse = jsonDecode(decodedBody);
    us.userList.value = [jsonResponse];
    print('구글 로그인했을 때 정보 ${us.userList}');
  } else {
    print('서버에 토큰 전송 실패: ${response}');
  }

}

/// 애플 로그인
Future<void> appleLogin() async {
  final dioClient = DioClient();
  final us = Get.put(UserState());
  String? tokens = await FirebaseMessaging.instance.getToken();
  await SignInWithApple.getAppleIDCredential(scopes: [
    AppleIDAuthorizationScopes.email,
    AppleIDAuthorizationScopes.fullName,
    // 사용할 사용자 정보 범위
  ]).then((AuthorizationCredentialAppleID user)async{
    print('user??? ${user}');
    final url = 'https://trip-story.site/user/oauth2/login/apple';
    final body = {
      "email":'${user.email}',
      "displayName": "${user.authorizationCode}",
      "familyName": "${user.familyName}",
      "givenName": "${user.givenName}",
      "identityToken": "${user.identityToken}",
      "state":"${user.state}",
      "userIdentifier": "${user.userIdentifier}",
      'fcmToken':tokens
    };
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      await dioClient.loginCookies('${response.headers['set-cookie']}');
      var decodedBody = utf8.decode(response.bodyBytes);
      var jsonResponse = jsonDecode(decodedBody);
      us.userList.value = [jsonResponse];
    }
  }).onError((error, stackTrace) {
    if (error is PlatformException) return;
    print('error ? ${error}');
  });
}
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