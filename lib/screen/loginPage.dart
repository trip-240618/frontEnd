import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tripStory/controller/userState.dart';
import '../app/api/userApi.dart';
import '../app/notification/firebase_cloud_messaging.dart';
import '../app/notification/local_notification_setting.dart';




class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final apiUserClient = ApiUserClient();
  final us = Get.put(UserState());
  @override
  void initState() {
    /// Fcm
    _requestPermissions();
    LocalNotifyCation().initializeNotification();
    FCM().setNotifications();

    Future.delayed(Duration.zero,()async{
      final token = await FirebaseMessaging.instance.getToken();
      print('token ${token}');
      final cookies = await apiUserClient.getCookies();
      // if (cookies != null) {
      //   /// 자동 로그인 처리 로직
      //   us.userList.value = await apiUserClient.autoLogin(cookies);
      //   print('userL ${us.userList[0]['name']}');
      //   Get.to(()=>SecondPage());
      // }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: ()async{
            /// 노약자 추가
            final CollectionReference ref = FirebaseFirestore.instance.collection('elder');
            await ref.add({
              'name': 'jiwoobabo', /// 이름
            }).then((doc) async {
            });
            // await UserApi.instance.unlink(); // 회원탈퇴
            // signInWithApple();
            // kakaoLogin();
            // googleLogin();
          },
          child: Center(child: Text('로그인 페이지'))),
    );
  }

  /// 카카오 로그인
  Future<void> kakaoLogin() async {
    /// 카카오톡 실행 가능 여부 확인
    /// 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        final oauthToken= await UserApi.instance.loginWithKakaoTalk();
        await apiUserClient.sendTokenToServer(oauthToken.accessToken,oauthToken.refreshToken.toString());
      } catch (error) {
        /// 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        /// 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        /// 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          final oauthToken = await UserApi.instance.loginWithKakaoAccount();
          await apiUserClient.sendTokenToServer(oauthToken.accessToken,oauthToken.refreshToken.toString());
          print('카카오계정으로 로그인 성공2');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        final oauthToken = await UserApi.instance.loginWithKakaoAccount();
        await apiUserClient.sendTokenToServer(oauthToken.accessToken,oauthToken.refreshToken.toString());
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }
  /// 구글 로그인
  Future<void> googleLogin() async {
    try {
      await _googleSignIn.signIn().then((value)async{
        if(value !=null){
          print('value?? ${value}');
          await apiUserClient.googleSendData(value!);
          setState(() {});
        }
      });
    } catch (error) {
      print(error);
    }
  }

  /// 애플 로그인
  Future<void> signInWithApple() async {
    SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName
      /// 사용할 사용자 정보 범위
    ]).then((AuthorizationCredentialAppleID user)async{
      await apiUserClient.appleSendData(user);
      /// 로그인 후 로직
    }).onError((error, stackTrace) {
      if (error is PlatformException) return;
      print('error ? ${error}');
    });
  }
  /// 알림 권한 여부 설정
  void _requestPermissions() {
    ///fcm
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    /// 안드로이드 일때
    if (Platform.isAndroid) {
      FirebaseMessaging.instance.requestPermission(
        badge: true,
        alert: true,
        sound: true,
      );
      var channel = const AndroidNotificationChannel(
        'tripFcm', 'tripFcm',
        description: 'this is tripFcm channel', // description
        importance: Importance.high,
      );
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    /// Ios 일 때
    else {
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }
}
