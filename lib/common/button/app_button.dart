import 'package:flutter/material.dart';
import 'package:tripStory/common/button/base/base_button.dart';
import 'package:tripStory/core/enum/button_type.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonLevel level;
  final bool isDisabled;
  final Widget? trailingIcon;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.level = ButtonLevel.primary,
    this.isDisabled = false,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _buttonColors(context, level, isDisabled);

    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: BaseButton(
        onTap: isDisabled ? null : onPressed,
        borderRadius: 4,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: context.style.body1Normal.copyWith(
                color: colors.fontColor,
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              trailingIcon!,
            ],
          ],
        ),
      ),
    );
  }

  ({Color backgroundColor, Color fontColor}) _buttonColors(
    BuildContext context,
    ButtonLevel level,
    bool disabled,
  ) {
    if (disabled) {
      return (backgroundColor: context.color.gray300, fontColor: context.color.gray400);
    }
    switch (level) {
      case ButtonLevel.primary:
        return (backgroundColor: context.color.gray900, fontColor: context.color.white);
      case ButtonLevel.secondary:
        return (backgroundColor: context.color.gray200, fontColor: context.color.gray600);
    }
  }
}
