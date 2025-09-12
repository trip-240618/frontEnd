import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/enum/button_type.dart';
import 'package:tripStory/core/util/font.dart';
import 'package:tripStory/presentation/common/button/app_button.dart';
import 'package:tripStory/presentation/common/dialog/base_dialog.dart';

class ButtonState {
  final String title;
  final ButtonLevel style;
  final VoidCallback action;

  const ButtonState({
    required this.title,
    required this.style,
    required this.action,
  });
}

class AlertViewState {
  final String title;
  final String? message;
  final List<ButtonState> buttons;

  const AlertViewState({
    required this.title,
    this.message,
    required this.buttons,
  });

  AlertViewState.confirm({
    required this.title,
    this.message,
    String confirmText = "확인",
    required VoidCallback onConfirm,
  }) : buttons = [
          ButtonState(
            title: confirmText,
            style: ButtonLevel.primary,
            action: onConfirm,
          ),
        ];

  AlertViewState.confirmCancel({
    required this.title,
    this.message,
    String confirmText = "확인",
    String cancelText = "취소",
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) : buttons = [
          ButtonState(
            title: cancelText,
            style: ButtonLevel.secondary,
            action: onCancel ?? () => Get.back(),
          ),
          ButtonState(
            title: confirmText,
            style: ButtonLevel.primary,
            action: onConfirm,
          ),
        ];
}

class CommonDialog extends StatelessWidget {
  final AlertViewState alertState;

  const CommonDialog({
    super.key,
    required this.alertState,
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
              alertState.title,
              style: f18Gray800w600,
              textAlign: TextAlign.center,
            ),
            if (alertState.message != null) ...[
              const SizedBox(height: 4),
              Text(alertState.message ?? "", style: f14Gray400w500, textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
      actions: [
        _buildActions(),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      children: alertState.buttons.map((button) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: button == alertState.buttons.last ? 0 : 12,
            ),
            child: AppButton(
              label: button.title,
              level: button.style,
              onPressed: button.action,
            ),
          ),
        );
      }).toList(),
    );
  }

  static void showConfirm({
    required String title,
    String? message,
    String confirmText = "확인",
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      CommonDialog(
        alertState: AlertViewState.confirm(
          title: title,
          message: message,
          confirmText: confirmText,
          onConfirm: onConfirm,
        ),
      ),
    );
  }

  static void showConfirmCancel({
    required String title,
    String? message,
    String confirmText = "확인",
    String cancelText = "취소",
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.dialog(
      CommonDialog(
        alertState: AlertViewState.confirmCancel(
          title: title,
          message: message,
          confirmText: confirmText,
          cancelText: cancelText,
          onConfirm: onConfirm,
          onCancel: onCancel,
        ),
      ),
    );
  }
}
