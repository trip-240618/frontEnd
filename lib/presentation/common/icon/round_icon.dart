import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';

class RoundIcon extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final double size;

  const RoundIcon._({
    super.key,
    required this.child,
    this.backgroundColor,
    this.size = 20,
  });

  factory RoundIcon.icon({
    Key? key,
    required String assetPath,
    Color? backgroundColor,
    Color? iconColor,
  }) {
    return RoundIcon._(
      key: key,
      backgroundColor: backgroundColor,
      size: 20,
      child: SvgIcon(
        assetPath: assetPath,
        color: iconColor,
      ),
    );
  }

  factory RoundIcon.number({
    Key? key,
    required int number,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return RoundIcon._(
      key: key,
      backgroundColor: backgroundColor,
      size: 20,
      child: Builder(
        builder: (context) => Text(
          "$number",
          style: context.style.caption1.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? context.color.gray900,
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
