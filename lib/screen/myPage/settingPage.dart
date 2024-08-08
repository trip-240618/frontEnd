import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../component/appbar.dart';
import '../../component/setting/settingArrowRow.dart';
import '../../util/color.dart';
import '../../util/font.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '설정',onTap: (){Get.back();}),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 알림
            Padding(
              padding: const EdgeInsets.only(top: 42, left: 20, right: 31, bottom: 38),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('알림', style: f20gray800w700,),
                  const SizedBox(height: 28,),
                  SettingArrowRow(
                      title: '앱 알림 설정',
                      onTap: (){print('앱 알림 설정');
                      }),
                ],
              ),
            ),
            Divider(
              thickness: 11,
              color: lightGray1,
            ),
            /// 계정 관리
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 20, right: 31, bottom: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('계정 관리', style: f20gray800w700,),
                  const SizedBox(height: 28,),
                  SettingArrowRow(
                      title: '계정 관리',
                      onTap: (){print('계정 관리');
                      }),
                  const SizedBox(height: 20,),
                  SettingArrowRow(
                      title: '회원 탈퇴',
                      onTap: (){print('회원 탈퇴');
                      }),
                ],
              ),
            ),
            Divider(
              thickness: 11,
              color: lightGray1,
            ),
            /// 서비스 설정
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 20, right: 30, bottom: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('서비스 설정', style: f20gray800w700,),
                  const SizedBox(height: 28,),
                  GestureDetector(
                    onTap: (){
                      print('위치 서비스');
                    },
                    child: Row(
                      children: [
                        Text('위치 서비스', style: f16darkGray1w400),
                        Spacer(),
                        Text('앱을 사용하는 동안', style: f16mainRedw400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 11,
              color: lightGray1,
            ),
            /// 정보
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 31, bottom: 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('정보', style: f20gray800w700,),
                  const SizedBox(height: 28,),
                  GestureDetector(
                    onTap: (){
                      print('앱 버전');
                    },
                    child: Row(
                      children: [
                        Text('앱 버전', style: f16darkGray1w400),
                        Spacer(),
                        Text('v 0.1', style: f16darkGray1w400),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SettingArrowRow(
                      title: '약관 및 정책',
                      onTap: (){print('약관 및 정책');
                      }),
                  const SizedBox(height: 20,),
                  SettingArrowRow(
                      title: '고객센터',
                      onTap: (){print('고객센터');
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 46),
              child: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  width: Get.width,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: lightGray2, width: 1),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    // 텍스트를 가운데에 위치시키기 위해 Center 위젯 추가
                    child: Text(
                      '로그아웃',
                      style: f16darkGray3w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
