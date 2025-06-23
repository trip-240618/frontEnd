import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/common/button/base/base_button.dart';
import 'package:tripStory/common/button/base/base_image_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class ProfileImageButton extends StatelessWidget {
  final XFile? pickedImage;
  final String? url;
  final VoidCallback? onPressed;
  final String iconPath;

  const ProfileImageButton({
    super.key,
    this.pickedImage,
    this.onPressed,
    required this.iconPath,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return BaseImageButton(
      url: url,
      onPressed: onPressed,
      pickedImage: pickedImage,
      errorIconSize: 24,
      errorIcon: IconConstants.defaultPerson,
      iconWidget: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.color.white,
          border: Border.all(
            width: 1,
            color: context.color.whiteEC,
          ),
        ),
        child: BaseButton(
          onTap: onPressed,
          borderRadius: 100,
          child: SvgIcon(
            assetPath: iconPath,
            color: context.color.gray500,
          ),
        ),
      ),
    );
  }
}
