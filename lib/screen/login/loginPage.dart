import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/app/sns/snsLogin.dart';
import 'package:tripStory/component/login/snsContainer.dart';
import 'package:tripStory/controller/userState.dart';
import '../../util/font.dart';
import '../main/mainPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final us = Get.put(UserState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 81,bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('가장 편한 방법으로',style: f24gray900w700,),
            Text('빠르게 시작해 보세요!',style: f24gray900w700,),
            Spacer(),
            Center(child: Text('10초면 됩니다. 여행이 편해질 거예요!',style: f14Gray500w500,)),
            const SizedBox(height: 18),
            KakaoContainer(onTap: ()async{
              print('3123');
              await kakaoLogin();
              // Get.to(()=>MainPage());
              // await us.kakaoLogin();
            }),
            const SizedBox(height: 18),
            GoogleContainer(onTap: (){
              Get.to(()=>MainPage());
            }),
            const SizedBox(height: 18),
            AppleContainer(onTap: (){})
          ],
        ),
      ),
    );
  }
}
