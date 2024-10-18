import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/screen/login/loginPage.dart';
import 'package:tripStory/util/color.dart';
import '../../../../component/appbar.dart';
import '../../../../component/bottomContainer.dart';
import '../../../../util/font.dart';

class SettingDeletePage extends StatefulWidget {
  const SettingDeletePage({super.key});

  @override
  State<SettingDeletePage> createState() => _SettingDeletePageState();
}

class _SettingDeletePageState extends State<SettingDeletePage> {
  final us = Get.put(UserState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '회원탈퇴', onTap: () {
        Get.back();
      },color: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18,),
            Text('회원탈퇴를 신청하기 전에',style: f24gray900w700,),
            Text('안내 사항을 꼭 확인해주세요!',style: f24gray900w700,),
            const SizedBox(height: 47,),
            Text('탈퇴 후 회원 정보 및 서비스 이용기록은 모두 삭제되어 복구가 불가능합니다.',style: f14gray600w500,),
            const SizedBox(height: 29,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                          color: gray600,
                          borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Text('삭제된 데이터는 복구되지 않습니다. 삭제되는 내용을 확인하시고 필요한 데이터는 미리 백업을 해주세요.',style: f12Gray600w500,)
                    ],
                  ),
                  const SizedBox(height: 24,),
                  Row(
                    children: [
                      Container(
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                            color: gray600,
                            borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Text('삭제된 데이터는 복구되지 않습니다. 삭제되는 내용을 확인하시고 필요한 데이터는 미리 백업을 해주세요.',style: f12Gray600w500,)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 42),
        child: BottomContainer(
            onTap: ()async{
              showConfirmCancelTapDialog(context, '회원탈퇴를 하시겠어요?', '탈퇴', null, ()async{
                await us.userDelete();
                Get.offAll(()=>LoginPage());
              });
            },title: '확인했어요',isBlack: true),
      ),
    );
  }
}
