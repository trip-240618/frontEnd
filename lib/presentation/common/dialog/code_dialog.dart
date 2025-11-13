import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/button/app_button.dart';
import 'package:tripStory/presentation/common/button/link_button.dart';
import 'package:tripStory/presentation/common/dialog/base_dialog.dart';

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
            Text(
              "초대코드 생성",
              textAlign: TextAlign.center,
              style: context.style.heading2.copyWith(
                color: context.color.gray600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              inviteCode,
              style: context.style.heading1.copyWith(
                color: context.color.gray600,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              "초대코드로 친구를 초대해보세요.\n방 생성 이후에도 초대코드를\n공유할 수 있습니다.",
              style: context.style.label1Reading.copyWith(
                color: context.color.gray400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            LinkButton(
              onPressed: onSendPressed,
              type: LinkButtonType.send,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                label: "여행방 이동",
                onPressed: onConfirmPressed,
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
      barrierDismissible: false,
      InviteCodeDialog(
        inviteCode: inviteCode,
        onSendPressed: onSendPressed,
        onConfirmPressed: onConfirmPressed,
      ),
    );
  }
}
