import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class UserState extends GetxController{
  final userList =[].obs; /// 유저 정보 리스트

  /// 카카오 로그인
  Future<void> kakaoLogin() async {
    // 카카오 로그인 구현 예제
    // 카카오톡 실행 가능 여부 확인
    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        final oauthToken= await UserApi.instance.loginWithKakaoTalk();
        await sendTokenToServer(oauthToken.accessToken,oauthToken.refreshToken.toString());
        await requestUserInfo();
        // final token = await TokenManagerProvider.instance.manager.getToken();
        // print('token?? ${token}');
        print('?? ${oauthToken}');
        // print('??token ${oauthToken.accessToken}');
        // print('??token ${oauthToken.refreshToken}');
      } catch (error) {
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공2');
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
      // print('31231${user}');
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
    /// 백엔드 서버로 토큰 전송
    var response = await http.get(
      Uri.parse('https://trip-story.site/user/oauth2/callback/kakao?code=${accessToken}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${accessToken}'
      },
    );
    var response2 = await http.get(
      Uri.parse('https://trip-story.site/hc'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': '${response.headers['set-cookie']}',
      },
    );
    print('Response status: ${response2.body}');
    if (response.statusCode == 200) {
      // print('re?? ${response.body}');
      print('서버에 토큰 전송 성공');
    } else {
      print('서버에 토큰 전송 실패: ${response.statusCode}');
    }
  }
  Future<void> hasTokens()async{
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('토큰 만료 $error');
        } else {
          print('토큰 정보 조회 실패 $error');
        }
        try {
          /// 카카오계정으로 로그인
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('로그인 성공 ${token.accessToken}');
        } catch (error) {
          print('로그인 실패 $error');
        }
      }
    } else {
      print('발급된 토큰 없음');
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('로그인 성공 ${token.accessToken}');
      } catch (error) {
        print('로그인 실패 $error');
      }
    }
  }
}