import 'package:flutter/material.dart';
import 'package:tripStory/common/button/base/base_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/extension/context_extension.dart';

enum LinkButtonType { link, send }

class LinkButton extends StatelessWidget {
  final bool disable;
  final VoidCallback onPressed;
  final LinkButtonType type;

  const LinkButton({
    super.key,
    this.disable = false,
    required this.onPressed,
    this.type = LinkButtonType.link,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = disable ? context.color.gray300 : context.color.gray700;
    final iconColor = disable ? context.color.gray400 : context.color.white;
    final double size = 60;
    final iconPath = switch (type) {
      LinkButtonType.link => IconConstants.chain,
      LinkButtonType.send => IconConstants.send,
    };

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: BaseButton(
        onTap: disable ? null : onPressed,
        borderRadius: 4,
        child: SvgIcon(
          assetPath: iconPath,
          color: iconColor,
        ),
      ),
    );
  }
}
