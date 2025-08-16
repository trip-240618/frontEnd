import 'package:flutter/material.dart';
import 'package:tripStory/core/util/font.dart';

class CircleBadge extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final double size;
  final bool enabled;
  final Color? backgroundColor;

  const CircleBadge({
    super.key,
    required this.text,
    this.textStyle,
    this.size = 20,
    this.enabled = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          text,
          style: textStyle ?? f12Whitew700,
        ),
      ),
    );
  }
}
