import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/common/button/base/base_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/common/image/round_thumbnail_image.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class BaseImageButton extends StatelessWidget {
  final XFile? pickedImage;
  final String? url;
  final VoidCallback? onPressed;
  final String? errorIcon;
  final double? errorIconSize;
  final Widget iconWidget;
  final Color? backgroundColor;
  final double? positioned;

  const BaseImageButton({
    super.key,
    this.pickedImage,
    this.onPressed,
    this.url,
    this.errorIcon,
    this.errorIconSize,
    required this.iconWidget,
    this.backgroundColor,
    this.positioned,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 98,
      height: 98,
      child: Stack(
        children: [
          BaseButton(
            onTap: onPressed,
            child: _buildImageContent(context),
          ),
          Positioned(
            right: positioned ?? 0,
            bottom: positioned ?? 0,
            child: iconWidget,
          ),
        ],
      ),
    );
  }

  Widget _buildImageContent(BuildContext context) {
    if (pickedImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.file(
          File(pickedImage!.path),
          width: 80,
          height: 80,
          fit: BoxFit.fill,
        ),
      );
    }
    if (url != null) {
      return RoundThumbnailImage(
        imageUrl: url,
        size: 80,
        errorIcon: errorIcon,
        errorIconSize: errorIconSize,
      );
    }

    return Ink(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.color.white,
        border: Border.all(
          color: context.color.gray200,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: SvgIcon(
          assetPath: IconConstants.photo,
          width: 28,
          height: 28,
          color: context.color.gray400,
        ),
      ),
    );
  }
}
