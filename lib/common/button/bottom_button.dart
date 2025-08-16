import 'package:flutter/material.dart';
import 'package:tripStory/common/button/app_button.dart';
import 'package:tripStory/core/enum/button_type.dart';

class BottomButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final ButtonLevel buttonType;
  final VoidCallback onTap;
  final Widget? trailingIcon;

  const BottomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.enabled = true,
    this.buttonType = ButtonLevel.primary,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 42,
      ),
      child: AppButton(
        label: text,
        onPressed: onTap,
        isDisabled: !enabled,
        level: buttonType,
        trailingIcon: trailingIcon,
      ),
    );
  }
}
