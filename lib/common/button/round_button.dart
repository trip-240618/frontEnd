import 'package:flutter/material.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';

class RoundedBoxButton extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final Widget? icon;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final bool enabled;
  final EdgeInsets? padding;
  final MainAxisAlignment? mainAxisAlignment;
  final VoidCallback? onTap;

  const RoundedBoxButton({
    super.key,
    this.text,
    this.textStyle,
    this.icon,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.padding,
    this.mainAxisAlignment,
    this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: width,
        height: height,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
        decoration: BoxDecoration(
          color: enabled ? backgroundColor : gray300,
          border: Border.all(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius ?? 100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null && text != null) const SizedBox(width: 5),
            if (text != null)
              Text(
                text ?? "",
                style: enabled ? textStyle : f16gray400w700,
              ),
          ],
        ),
      ),
    );
  }
}
