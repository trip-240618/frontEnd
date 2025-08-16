import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/button/app_button.dart';
import 'package:tripStory/common/dialog/base_dialog.dart';
import 'package:tripStory/core/enum/button_type.dart';
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
              child: AppButton(
                label: "취소",
                level: ButtonLevel.secondary,
                onPressed: () => Get.back(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                label: confirmText,
                onPressed: onConfirm,
              ),
            ),
          ],
        )
      ],
    );
  }

  static void show({
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
