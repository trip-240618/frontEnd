import 'package:flutter/material.dart';
import 'package:tripStory/util/font.dart';

class BaseTileButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color? tileColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;

  const BaseTileButton({
    super.key,
    required this.text,
    this.tileColor,
    this.borderColor,
    this.textStyle = f15gray800w500,
    this.onTap,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        horizontalTitleGap: 8,
        tileColor: tileColor ?? Colors.white,
        dense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 4,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? Colors.white, width: 1.5),
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
