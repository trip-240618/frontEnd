import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/button/round_button.dart';
import 'package:tripStory/common/dialog/base_dialog.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';

class InviteCodeDialog extends StatelessWidget {
  final String inviteCode;
  final VoidCallback onSendPressed;
  final VoidCallback onConfirmPressed;

  const InviteCodeDialog({
    super.key,
    required this.inviteCode,
    required this.onSendPressed,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      content: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text("초대코드 생성", textAlign: TextAlign.center, style: f20gray600w700),
            const SizedBox(height: 8),
            Text(inviteCode, style: f28gray600w700),
            const SizedBox(height: 18),
            Text(
              "초대코드로 친구를 초대해보세요.\n방 생성 이후에도 초대코드를\n공유할 수 있습니다.",
              style: f14Gray400w500,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            RoundedBoxButton(
              icon: SvgPicture.asset("assets/icon/send.svg", fit: BoxFit.none),
              width: 60,
              height: 60,
              borderRadius: 4,
              onTap: onSendPressed,
              backgroundColor: gray200,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RoundedBoxButton(
                text: "여행방 이동",
                textStyle: f16Whitew600,
                height: 60,
                borderRadius: 4,
                onTap: onConfirmPressed,
                backgroundColor: gray900,
              ),
            ),
          ],
        )
      ],
    );
  }

  static void show(
    BuildContext context, {
    required String inviteCode,
    required VoidCallback onSendPressed,
    required VoidCallback onConfirmPressed,
  }) {
    Get.dialog(
      InviteCodeDialog(
        inviteCode: inviteCode,
        onSendPressed: onSendPressed,
        onConfirmPressed: onConfirmPressed,
      ),
    );
  }
}
