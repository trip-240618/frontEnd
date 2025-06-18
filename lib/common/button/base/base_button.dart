import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const BaseButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: child,
      ),
    );
  }
}
