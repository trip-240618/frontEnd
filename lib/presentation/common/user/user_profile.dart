import 'package:flutter/material.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/presentation/common/image/round_thumbnail_image.dart';

class UserProfile extends StatelessWidget {
  final double size;
  final String thumbnailImage;

  const UserProfile({
    super.key,
    required this.size,
    required this.thumbnailImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: RoundThumbnailImage(
        imageUrl: thumbnailImage,
        errorIcon: IconConstants.defaultPerson,
      ),
    );
  }
}
