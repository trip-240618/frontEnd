import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/custom_cache_manager.dart';
import 'package:tripStory/util/extension/context_extension.dart';

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
    if (imageUrl.isEmpty) {
      return _EmptyImage(
        icon: SvgIcon(
          assetPath: errorIcon ?? IconConstants.appLogo,
          fit: BoxFit.fill,
          width: errorIconSize,
          height: errorIconSize,
        ),
        width: width,
        height: height,
      );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheManager: CustomCacheManager(),
      placeholder: (context, url) => SizedBox(
        width: width,
        height: height,
      ),
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      errorWidget: (context, url, error) => _EmptyImage(
        icon: SvgIcon(
          assetPath: errorIcon ?? IconConstants.appLogo,
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

class _EmptyImage extends StatelessWidget {
  final Widget icon;
  final double width;
  final double height;

  const _EmptyImage({
    required this.icon,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.color.gray200,
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
