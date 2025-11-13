import 'package:flutter/material.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/button/base/base_tile_button.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';

class TileListButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? tileColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final VoidCallback? onTrailingTap;
  final Widget? trailing;
  final Widget? leading;
  final bool showTrailing;

  const TileListButton({
    super.key,
    required this.text,
    this.textStyle,
    this.tileColor,
    this.onTap,
    this.onTrailingTap,
    this.borderColor,
    this.trailing,
    this.leading,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTileButton(
      text: text,
      textStyle: textStyle ??
          context.style.label1Normal.copyWith(
            color: context.color.gray700,
          ),
      onTap: onTap,
      tileColor: tileColor,
      borderColor: borderColor,
      leading: leading,
      trailing: showTrailing
          ? trailing ??
              GestureDetector(
                onTap: onTrailingTap,
                child: SvgIcon(
                  assetPath: IconConstants.rightArrowTick,
                ),
              )
          : null,
    );
  }
}
