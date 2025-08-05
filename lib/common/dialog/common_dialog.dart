import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/button/round_button.dart';
import 'package:tripStory/common/dialog/base_dialog.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/font.dart';

class CommonDialog extends StatelessWidget {
  final String title;
  final String? message;
  final String confirmText;
  final VoidCallback onConfirm;

  const CommonDialog({
    super.key,
    required this.title,
    required this.confirmText,
    this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.only(
          top: 36,
          bottom: 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: f18Gray800w600,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: 4),
              Text(message!, style: f14Gray400w500, textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: RoundedBoxButton(
                onTap: Get.back,
                text: "취소",
                textStyle: context.style.body1Normal,
                height: 58,
                borderRadius: 10,
                backgroundColor: context.color.gray200,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RoundedBoxButton(
                onTap: onConfirm,
                text: confirmText,
                textStyle: context.style.body1Normal.copyWith(
                  color: context.color.white,
                ),
                height: 58,
                borderRadius: 10,
                backgroundColor: context.color.black,
              ),
            ),
          ],
        )
      ],
    );
  }

  static void show(
    BuildContext context, {
    required String title,
    String? message,
    required String confirmText,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      CommonDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        onConfirm: onConfirm,
      ),
    );
  }
}
