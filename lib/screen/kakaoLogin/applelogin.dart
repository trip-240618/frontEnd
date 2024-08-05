import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

class AppleLogin extends StatefulWidget {
  const AppleLogin({super.key});

  @override
  State<AppleLogin> createState() => _AppleLoginState();
}

class _AppleLoginState extends State<AppleLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          signInWithApple();
        },
          child: Center(child: Text('111'))),
    );
  }

  /// 애플 로그인
  Future<void> signInWithApple() async {
    SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName
      // 사용할 사용자 정보 범위
    ]).then((AuthorizationCredentialAppleID user)async{
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
        /// Send the data as a JSON payload
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        );
        print('response body ${response.body}');
      /// 로컬에 저장해서 자동로그인
      // print('user?? ${user.userIdentifier}');
      //
      // 로그인 후 로직
    }).onError((error, stackTrace) {
      if (error is PlatformException) return;
      print('error ? ${error}');
    });
  }
}
