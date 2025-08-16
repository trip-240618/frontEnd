import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/button/base/base_button.dart';

class BoxButton extends StatelessWidget {
  final String label;
  final Color? color;
  final bool enabled;
  final VoidCallback onPressed;

  const BoxButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onTap: onPressed,
      borderRadius: 8,
      backgroundColor: color ?? (enabled ? context.color.gray900 : context.color.gray300),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: context.style.label1Normal.copyWith(
            color: enabled ? context.color.white : context.color.gray400,
          ),
        ),
      ),
    );
  }
}
