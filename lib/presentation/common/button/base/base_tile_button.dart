import 'package:flutter/material.dart';
import 'package:tripStory/core/util/font.dart';

class BaseTileButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color? tileColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets? contentPadding;

  const BaseTileButton({
    super.key,
    required this.text,
    this.tileColor,
    this.borderColor,
    this.textStyle = f15gray800w500,
    this.onTap,
    this.leading,
    this.trailing,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: ListTile(
        horizontalTitleGap: 8,
        tileColor: tileColor ?? Colors.white,
        dense: true,
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        minTileHeight: 0,
        minVerticalPadding: 0,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? Colors.white, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        leading: leading,
        title: Text(
          text,
          style: textStyle,
        ),
        trailing: trailing,
      ),
    );
  }
}
