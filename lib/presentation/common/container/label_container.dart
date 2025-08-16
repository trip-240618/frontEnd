import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';

class LabelContainer extends StatelessWidget {
  final String label;
  final String? leadingIcon;
  final Color? iconColor;
  final Color? backgroundColor;

  const LabelContainer({
    super.key,
    required this.label,
    this.leadingIcon,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: context.color.gray200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (leadingIcon != null) ...[
              SvgIcon(
                assetPath: leadingIcon!,
                color: iconColor,
              ),
              const SizedBox(
                width: 6,
              ),
            ],
            Text(
              label,
              style: context.style.body2Normal,
            ),
          ],
        ),
      ),
    );
  }
}
