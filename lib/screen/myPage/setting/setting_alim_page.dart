import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/button/switchButton.dart';
import 'package:tripStory/controller/notificationState.dart';
import 'package:tripStory/controller/userState.dart';
import '../../../component/appbar.dart';
import '../../../util/font.dart';

class SettingAlimPage extends StatefulWidget {
  const SettingAlimPage({super.key});

  @override
  State<SettingAlimPage> createState() => _SettingAlimPageState();
}

class _SettingAlimPageState extends State<SettingAlimPage> {
  final us = Get.put(UserState());
  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      us.getNotificationSetting();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '알림 설정', onTap: () {
        Get.back();
      },color: Colors.white,),
      body: Obx(()=>Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 46),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('일정알림',style: f16gray800w700,),
                    const SizedBox(height: 5,),
                    Text('여행 일정과 관련된 알림을 받습니다.',style: f12gray400w500,)
                  ],
                ),
                Spacer(),
                SwitchButton(onTap: (){
                  us.userAlimSetting['activePlan'] = !us.userAlimSetting['activePlan'];
                  us.userAlimSetting.refresh();
                  us.changeNotificationSetting(us.userAlimSetting);
                }, value: us.userAlimSetting['activePlan']??true)
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('좋아요, 댓글 알림',style: f16gray800w700,),
                    const SizedBox(height: 5,),
                    Text('여행 기록 업로드나 댓글에 대한 알림을 받습니다.',style: f12gray400w500,)
                  ],
                ),
                Spacer(),
                SwitchButton(onTap: (){
                  us.userAlimSetting['activeLikeReply'] = !us.userAlimSetting['activeLikeReply'];
                  us.userAlimSetting.refresh();
                  us.changeNotificationSetting(us.userAlimSetting);
                }, value: us.userAlimSetting['activeLikeReply']??true)
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('마케팅 알림',style: f16gray800w700,),
                    const SizedBox(height: 5,),
                    Text('새로운 소식이나 이벤트와 관련된 알림을 받습니다.',style: f12gray400w500,)
                  ],
                ),
                Spacer(),
                SwitchButton(onTap: (){
                  us.userAlimSetting['activeMarketing'] = !us.userAlimSetting['activeMarketing'];
                  us.userAlimSetting.refresh();
                  us.changeNotificationSetting(us.userAlimSetting);
                }, value: us.userAlimSetting['activeMarketing']??true)
              ],
            ),
            const SizedBox(height: 24,),
          ],
        ),
      )),
    );
  }
}
