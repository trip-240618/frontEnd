import 'package:flutter/material.dart';
import 'package:tripStory/common/button/base/base_button.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class BoxButton extends StatelessWidget {
  final String label;
  final Color? color;
  final VoidCallback onPressed;

  const BoxButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onTap: onPressed,
      borderRadius: 8,
      backgroundColor: color ?? context.color.gray900,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            color: context.color.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
