import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/common/button/base/base_button.dart';

class ImageButton extends StatelessWidget {
  final XFile? pickedImage;
  final VoidCallback? onPressed;

  const ImageButton({
    super.key,
    required this.pickedImage,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      height: 92,
      child: Stack(
        children: [
          BaseButton(
            onTap: onPressed,
            child: _buildImageContent(),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: BaseButton(
              onTap: onPressed,
              child: SvgPicture.asset("assets/icon/plus.svg"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContent() {
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

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1.0),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icon/image.svg',
          width: 28,
          colorFilter: const ColorFilter.mode(
            Color(0xFFBDBDBD),
            BlendMode.srcIn,
          ), // gray400
        ),
      ),
    );
  }
}
