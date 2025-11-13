import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/button/base/base_button.dart';

class TabBox extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool selected;

  const TabBox({
    super.key,
    required this.label,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected ? context.color.gray900 : context.color.gray200;
    final fontColor = selected ? context.color.white : context.color.gray400;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor,
      ),
      child: BaseButton(
        onTap: onPressed,
        borderRadius: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          child: Text(
            label,
            style: context.style.label1Normal.copyWith(
              color: fontColor,
            ),
          ),
        ),
      ),
    );
  }
}
