import 'package:flutter/material.dart';
import 'package:tripStory/util/color.dart';

class EmptyImage extends StatelessWidget {
  final Widget icon;
  final double width;
  final double height;
  final Color backgroundColor;
  final double borderRadius;

  const EmptyImage({
    super.key,
    required this.icon,
    required this.width,
    required this.height,
    this.backgroundColor = gray100,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
