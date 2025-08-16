import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/presentation/common/button/base/base_button.dart';
import 'package:tripStory/presentation/common/button/base/base_image_button.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';

class PictureImageButton extends StatelessWidget {
  final XFile? pickedImage;
  final String? url;
  final VoidCallback? onPressed;

  const PictureImageButton({
    super.key,
    this.onPressed,
    this.pickedImage,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return BaseImageButton(
      onPressed: onPressed,
      pickedImage: pickedImage,
      positioned: 10,
      url: url,
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
