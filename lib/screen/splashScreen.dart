import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/screen/login/loginPage.dart';
import 'package:tripStory/screen/main/mainPage.dart';

import '../app/notification/firebase_cloud_messaging.dart';
import '../app/notification/local_notification_setting.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool jailbroken = false;
  bool developerMode = false;
  final us = Get.put(UserState());
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      requestNotificationPermissions();
      await LocalNotifyCation().initializeNotification();
      await FCM().setNotifications();
      initPlatformState();
    });

    super.initState();
  }

  Future<void> initPlatformState() async {
    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
    } on PlatformException {
      jailbroken = true;
    }
    final cookies = await us.apiUserClient.dioClient.getRefreshToken();
    print('cock?? ${cookies}');
    if (cookies != null) {
      String? tokens = await FirebaseMessaging.instance.getToken();
      await us.autoLogin();
      if(us.userList.isNotEmpty){
        await us.tokenUpdate(tokens!);
      }
    }
    Future.delayed(Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return Container(color: Colors.white);
    }else{
      if (jailbroken) {
        return DialogExample();
      } else {
        FlutterNativeSplash.remove();
        return us.userList.isNotEmpty?MainPage():LoginPage();
      }
    }
  }
}