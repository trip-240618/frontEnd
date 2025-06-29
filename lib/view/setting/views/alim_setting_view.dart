import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/view/setting/controllers/alim_setting_controller.dart';
import 'package:tripStory/view/setting/models/alim_setting_state.dart';

class AlimSettingView extends StatefulWidget {
  const AlimSettingView({
    super.key,
  });

  @override
  State<AlimSettingView> createState() => _AlimSettingViewState();
}

class _AlimSettingViewState extends State<AlimSettingView> {
  final us = Get.put(UserState());

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      us.getNotificationSetting();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        text: "설정1",
      ),
      body: GetBuilder<AlimSettingController>(builder: (controller) {
        if (controller.state.status == AlimSettingStatus.initial) {
          return SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 46,
          ),
          child: Column(
            children: [
              _AlimSettingTile(
                title: "일정알림",
                subTitle: "여행 일정과 관련된 알림을 받습니다.",
                value: controller.state.isScheduleAlim,
                onChanged: (value) => controller.onScheduleAlimChanged(value),
              ),
              const SizedBox(
                height: 30,
              ),
              _AlimSettingTile(
                title: "좋아요, 댓글 알림",
                subTitle: "여행 기록 업로드나 댓글에 대한 알림을 받습니다.",
                value: controller.state.isLikeAlim,
                onChanged: (value) => controller.onLikeReplyAlimChanged(value),
              ),
              const SizedBox(
                height: 30,
              ),
              _AlimSettingTile(
                title: "마케팅 알림",
                subTitle: "새로운 소식이나 이벤트와 관련된 알림을 받습니다.",
                value: controller.state.isMarketingAlim,
                onChanged: (value) => controller.onMarketingChanged(value),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _AlimSettingTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _AlimSettingTile({
    required this.title,
    required this.subTitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.style.body1Normal,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subTitle,
              style: context.style.caption1.copyWith(
                color: context.color.gray400,
              ),
            )
          ],
        ),
        Spacer(),
        CupertinoSwitch(
          value: value,
          onChanged: (value) => onChanged(value),
          activeTrackColor: context.color.gray900,
          inactiveTrackColor: Color(0xFF787880).withValues(alpha: 0.16),
        ),
      ],
    );
  }
}
