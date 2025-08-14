import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/box/box_button.dart';
import 'package:tripStory/common/user/user_field.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/view/trip/controllers/trip_room_member_controller.dart';

class TripRoomMemberView extends StatelessWidget {
  const TripRoomMemberView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.gray50,
      appBar: AppAppbar(
        text: "여행방 멤버",
        backgroundColor: context.color.gray50,
        actionWidget: BoxButton(
          label: "여행방 나가기",
          color: context.color.red,
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 28,
        ),
        child: GetBuilder<TripRoomMemberController>(
          builder: (controller) {
            return Container(
              decoration: BoxDecoration(
                color: context.color.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.color.gray200),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: controller.tripRoomInfo?.memberCount,
                itemBuilder: (context, index) {
                  final member = controller.members[index];

                  return UserField(
                    name: member.nickname,
                    isLeader: member.leader,
                    isMe: controller.isMe(member),
                    onTrailingPressed: () {},
                    thumbnailImage: member.thumbnail ?? "",
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
