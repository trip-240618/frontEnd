import 'package:flutter/material.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class LabelContainer extends StatelessWidget {
  final String label;
  final String? leadingIcon;
  final Color? iconColor;

  const LabelContainer({
    super.key,
    required this.label,
    this.leadingIcon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
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
