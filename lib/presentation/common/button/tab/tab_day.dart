import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';

class TabDay extends StatelessWidget {
  final String label;
  final Color color;

  const TabDay({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
        color: context.color.white,
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: context.style.label1Normal.copyWith(
          color: color,
        ),
      ),
    );
  }
}
