import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/button/base/base_button.dart';
import 'package:tripStory/core/enum/button_type.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';

class BottomButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final ButtonType? buttonType;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final Widget? textLabel;

  const BottomButton({
    super.key,
    required this.text,
    this.onTap,
    this.enabled = true,
    this.backgroundColor = gray900,
    this.buttonType = ButtonType.primary,
    this.textLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 58,
      decoration: BoxDecoration(
        color: buttonType == ButtonType.secondary
            ? gray200
            : enabled
                ? backgroundColor
                : gray300,
      ),
      child: BaseButton(
        onTap: enabled ? onTap : null,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: buttonType == ButtonType.secondary
                    ? f16gray600w700
                    : enabled
                        ? f16Whitew700
                        : f16gray400w700,
              ),
              if (textLabel != null) ...[
                SizedBox(width: 10),
                textLabel!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
