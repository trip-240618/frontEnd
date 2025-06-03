import 'package:flutter/material.dart';
import 'package:tripStory/util/color.dart';

class RoundedBoxButton extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const RoundedBoxButton({
    super.key,
    required this.child,
    this.backgroundColor = gray200,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
