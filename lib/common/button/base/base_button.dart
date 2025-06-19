import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double? borderRadius;
  final Widget child;

  const BaseButton({
    super.key,
    required this.onTap,
    this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius ?? 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
        child: child,
      ),
    );
  }
}
