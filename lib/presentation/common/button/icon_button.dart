import 'package:flutter/material.dart';
import 'package:tripStory/presentation/common/button/base/base_button.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';

class AppIconButton extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final VoidCallback? onTap;

  const AppIconButton({
    super.key,
    required this.assetPath,
    this.width = 24,
    this.height = 24,
    this.fit = BoxFit.none,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onTap: onTap,
      borderRadius: 100,
      child: SizedBox(
        width: 36,
        height: 36,
        child: SvgIcon(
          assetPath: assetPath,
          width: width,
          height: height,
          fit: fit,
          color: color,
        ),
      ),
    );
  }
}
