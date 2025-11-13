import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';

class NumberCircle extends StatelessWidget {
  final int count;
  final Color? color;
  final TextStyle? textStyle;
  final double? fontSize;
  final double size;

  const NumberCircle({
    super.key,
    required this.count,
    this.color,
    this.textStyle,
    this.fontSize,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.color.blue;

    final effectiveTextStyle = textStyle ??
        context.style.caption1.copyWith(
          color: context.color.white,
        );

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: effectiveColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          "$count",
          style: effectiveTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
