import 'package:flutter/material.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class FloatingPlusButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const FloatingPlusButton(
      {super.key, required this.onPressed, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 60,
      height: height ?? 60,
      child: FloatingActionButton(
        onPressed: onPressed,
        shape: CircleBorder(),
        backgroundColor: context.color.gray900,
        child: SvgIcon(
          assetPath: IconConstants.mainPlus,
          color: context.color.white,
        ),
      ),
    );
  }
}
