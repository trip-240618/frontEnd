import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/app/sns/snsLogin.dart';
import 'package:tripStory/component/container/snsContainer.dart';
import 'package:tripStory/controller/userState.dart';
import '../../util/font.dart';
import '../main/mainPage.dart';
import 'register/term.dart';

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
        padding: const EdgeInsets.only(left: 20,right: 20,top: 107,bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이제부터',style: f22gray900w700,),
            Text('트립스토리와',style: f22gray900w700,),
            Text('여행을 간단하게 기록해 보세요',style: f22gray900w700,),
            Spacer(),
            Center(child: Text('트립스토리는 간편 로그인을 지원해요',style: f14gray600w500,)),
            const SizedBox(height: 18),
            KakaoContainer(onTap: ()async{
              // await UserApi.instance.unlink();
              await kakaoLogin();
              if(us.userList[0].type=='register'){
                  Get.to(()=>TermPage());
              } else if(us.userList[0].type=='login'){
                Get.offAll(()=>MainPage());
              }
              else{
                print('로그인실패');
              }
              // Get.to(()=>MainPage());
            }),
            const SizedBox(height: 18),
            GoogleContainer(onTap: ()async{
              await googleLogin();
              if(us.userList.isNotEmpty&&us.userList[0].type=='register'){
                Get.to(()=>TermPage());
              }else if(us.userList.isNotEmpty&&us.userList[0].type=='login'){
                Get.offAll(()=>MainPage());
              }
            }),
            const SizedBox(height: 18),
            AppleContainer(onTap: ()async{
              await appleLogin();
              if(us.userList[0].type=='register'){
                Get.to(()=>TermPage());
              }else if(us.userList[0].type=='login'){
                Get.offAll(()=>MainPage());
              }
            })
          ],
        ),
      ),
    );
  }
}
