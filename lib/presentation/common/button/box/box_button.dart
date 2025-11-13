import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/button/base/base_button.dart';

class BoxButton extends StatelessWidget {
  final String label;
  final Color? color;
  final bool enabled;
  final double? borderRadius;
  final double? height;
  final VoidCallback onPressed;

  const BoxButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.color,
    this.borderRadius,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onTap: onPressed,
      borderRadius: borderRadius ?? 8,
      backgroundColor: color ?? (enabled ? context.color.gray900 : context.color.gray300),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        height: height,
        child: Center(
          child: Text(
            label,
            style: context.style.label1Normal.copyWith(
              color: enabled ? context.color.white : context.color.gray400,
            ),
          ),
        ),
      ),
    );
  }
}
