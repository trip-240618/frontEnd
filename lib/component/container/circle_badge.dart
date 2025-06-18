import 'package:flutter/material.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';

class CircleBadge extends StatelessWidget {
  final String text;
  final double size;
  final bool enabled;

  const CircleBadge({
    super.key,
    required this.text,
    this.size = 20,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: enabled ? gray900 : gray200,
      ),
      child: Center(
        child: Text(
          text,
          style: f12Whitew700,
        ),
      ),
    );
  }
}
