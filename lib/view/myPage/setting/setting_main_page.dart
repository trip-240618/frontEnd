import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/container/settingArrowRow.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/url_launch.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/login/loginPage.dart';
import 'package:tripStory/view/myPage/setting/cancel/setting_delete_page.dart';
import 'package:tripStory/view/myPage/setting/setting_alim_page.dart';



class SettingMainPage extends StatefulWidget {
  const SettingMainPage({super.key});

  @override
  State<SettingMainPage> createState() => _SettingMainPageState();
}

class _SettingMainPageState extends State<SettingMainPage> {
  final us = Get.put(UserState());
  String locationStatusText = '확인 중...';
  String versionText = '0.0.0';

  @override
  void initState() {
    super.initState();
    _initializeSettings();
  }

  Future<void> _initializeSettings() async {
    try {
      /// 앱 버전 정보 가져오기
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String fetchedVersion = packageInfo.version;

      /// 위치 권한 상태 가져오기
      String fetchedLocationStatus = await getLocationPermissionStatus();

      setState(() {
        versionText = fetchedVersion;
        locationStatusText = fetchedLocationStatus;
      });
    } catch (e) {
      print('초기화 중 에러 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '설정', onTap: () {
        Get.back();
      },color: Colors.white,),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            /// 알림
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('알림', style: f20gray800w700,),
                  const SizedBox(height: 10,),
                  SettingArrowRow(
                      title: '알림 설정',
                      onTap: (){
                        Get.to(()=>SettingAlimPage());
                      }),
                ],
              ),
            ),
            const SizedBox(height: 16,),
            Divider(
              thickness: 6,
              color: lightGray1,
            ),
            const SizedBox(height: 33,),
            /// 계정 관리
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('계정 관리', style: f20gray800w700,),
                  const SizedBox(height: 10,),
                  SettingArrowRow(
                      title: '회원 탈퇴',
                      onTap: (){
                        Get.to(()=>SettingDeletePage());
                      }),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      showConfirmCancelTapDialog(context, '로그아웃을 하시겠어요?', '확인', null, (){
                        Get.offAll(()=>LoginPage());
                        us.logOut();
                      });
                    },
                      child: Container(
                          height: 44,
                          child: Text('로그아웃',style: f14Gray700w500,)))
                  ],
              ),
            ),
            const SizedBox(height: 16,),
            Divider(
              thickness: 6,
              color: lightGray1,
            ),
            const SizedBox(height: 33,),
            /// 서비스 설정
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('서비스 설정', style: f20gray800w700,),
                    const SizedBox(height: 28,),
                    Row(
                      children: [
                        Text('위치 서비스',style: f14Gray700w500,),
                        Spacer(),
                        Text(locationStatusText, style: f14bluew500,)
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28,),
            Divider(
              thickness: 6,
              color: lightGray1,
            ),
            /// 정보
            const SizedBox(height: 33,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20,bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('정보', style: f20gray800w700,),
                  const SizedBox(height: 28,),
                  Row(
                    children: [
                      Text('앱 버전',style: f14Gray700w500,),
                      Spacer(),
                      Text('v ${versionText}', style: f12Gray800w600),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  SettingArrowRow(
                      title: '약관 및 정책',
                      onTap: ()async{
                        await urlLaunch('https://trip-story.site/policy/privacy');
                      })
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
