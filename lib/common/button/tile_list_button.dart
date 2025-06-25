import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripStory/common/button/base/base_tile_button.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class TileListButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? tileColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final VoidCallback? onTrailingTap;

  const TileListButton({
    super.key,
    required this.text,
    this.textStyle,
    this.tileColor,
    this.onTap,
    this.onTrailingTap,
    this.borderColor,
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
      trailing: GestureDetector(
        onTap: onTrailingTap,
        child: SvgPicture.asset("assets/icon/arrow.svg"),
      ),
    );
  }
}
