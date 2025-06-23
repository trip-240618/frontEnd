import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripStory/common/image/empty_image.dart';
import 'package:tripStory/core/constants/icon_constants.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double width;
  final double height;
  final String? errorIcon;
  final double? errorIconSize;

  const CachedImage({
    required this.imageUrl,
    this.fit = BoxFit.cover,
    required this.width,
    required this.height,
    this.errorIcon,
    super.key,
    this.errorIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: fit),
        ),
      ),
      errorWidget: (context, url, error) => EmptyImage(
        icon: SvgPicture.asset(
          errorIcon ?? IconConstants.appLogo,
          fit: BoxFit.fill,
          width: errorIconSize,
          height: errorIconSize,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
