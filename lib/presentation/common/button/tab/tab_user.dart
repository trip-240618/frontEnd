import 'package:flutter/material.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/button/base/base_button.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';

class TabUser extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;
  final int memberCount;

  const TabUser({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    required this.memberCount,
  });

  @override
  Widget build(BuildContext context) {
    final fontColor = isEnabled ? context.color.gray900 : context.color.gray600;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: context.color.gray200,
      ),
      child: BaseButton(
        onTap: onPressed,
        borderRadius: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 6,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgIcon(
                assetPath: IconConstants.smallUser,
                color: fontColor,
              ),
              const SizedBox(width: 5),
              Text(
                "$memberCount",
                style: context.style.label1Normal.copyWith(
                  color: fontColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
