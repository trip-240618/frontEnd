import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:tripStory/app/api/userApi.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/app/notification/local_notification_setting.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/view/login/loginPage.dart';
import 'package:tripStory/view/main/main_page/views/main_page.dart';



class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool jailbroken = false;
  bool developerMode = false;
  final apiUserClient = ApiUserClient(DioClient());
  final us = Get.put(UserState());
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      // await us.checkNetworkAndProceed();
      await us.versionCheck(context);
      requestNotificationPermissions();
      await LocalNotifyCation().initializeNotification();
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
    if (cookies != null) {
      // String? tokens = await FirebaseMessaging.instance.getToken();
      await us.autoLogin();
      if(us.userList.isNotEmpty){
        await us.tokenUpdate('');
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