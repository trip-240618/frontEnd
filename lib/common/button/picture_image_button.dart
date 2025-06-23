import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/common/button/base/base_button.dart';
import 'package:tripStory/common/button/base/base_image_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/core/constants/icon_constants.dart';

class PictureImageButton extends StatelessWidget {
  final XFile? pickedImage;
  final VoidCallback? onPressed;

  const PictureImageButton({
    super.key,
    this.onPressed,
    this.pickedImage,
  });

  @override
  Widget build(BuildContext context) {
    return BaseImageButton(
      onPressed: onPressed,
      pickedImage: pickedImage,
      iconWidget: BaseButton(
        borderRadius: 100,
        onTap: onPressed,
        child: SvgIcon(
          assetPath: IconConstants.plus,
        ),
      ),
    );
  }
}
