import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/button/base/base_tile_button.dart';

class TileListButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? tileColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final VoidCallback? onTrailingTap;
  final Widget? trailing;

  const TileListButton({
    super.key,
    required this.text,
    this.textStyle,
    this.tileColor,
    this.onTap,
    this.onTrailingTap,
    this.borderColor,
    this.trailing,
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
      trailing: trailing ??
          GestureDetector(
            onTap: onTrailingTap,
            child: SvgPicture.asset("assets/icon/arrow.svg"),
          ),
    );
  }
}
