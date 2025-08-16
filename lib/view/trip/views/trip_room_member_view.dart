import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/box/box_button.dart';
import 'package:tripStory/common/dialog/common_dialog.dart';
import 'package:tripStory/common/divider/common_divider.dart';
import 'package:tripStory/common/user/user_field.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/view/trip/controllers/trip_room_member_controller.dart';

class TripRoomMemberView extends StatelessWidget {
  const TripRoomMemberView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TripRoomMemberController>();

    return Scaffold(
      backgroundColor: context.color.gray50,
      appBar: AppAppbar(
        text: "여행방 멤버",
        backgroundColor: context.color.gray50,
        actionWidget: !controller.isRoomLeader
            ? null
            : BoxButton(
                label: "여행방 나가기",
                color: context.color.red,
                onPressed: () => showRoomLeaveDialog(
                  onConfirm: () => controller.onTripRoomLeavePressed(),
                ),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 28,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: context.color.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.color.gray200),
          ),
          child: GetBuilder<TripRoomMemberController>(
            builder: (controller) {
              return ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: controller.members.length,
                itemBuilder: (context, index) {
                  final member = controller.members[index];
                  return UserField(
                      name: member.nickname,
                      isLeader: member.leader,
                      isMe: controller.isMe(member),
                      onTrailingPressed: () => showKickDialog(
                            onConfirm: () => controller.onKickMemberPressed(member.uuid),
                          ),
                      thumbnailImage: member.thumbnail ?? "");
                },
                separatorBuilder: (context, index) => const CommonDivider(),
              );
            },
          ),
        ),
      ),
    );
  }

  void showKickDialog({
    required VoidCallback onConfirm,
  }) {
    CommonDialog.show(
      title: "여행방 맴버를 내보내시겠습니까?",
      confirmText: "확인",
      onConfirm: onConfirm,
    );
  }

  void showRoomLeaveDialog({
    required VoidCallback onConfirm,
  }) {
    CommonDialog.show(
      title: "여행방을 나가시겠습니까?",
      confirmText: "확인",
      onConfirm: onConfirm,
    );
  }
}
