import 'package:flutter/material.dart';
import 'package:tripStory/common/image/cached_image.dart';

class RoundThumbnailImage extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final double radius;
  final BoxFit fit;
  final Widget? defaultIcon;

  const RoundThumbnailImage({
    super.key,
    required this.imageUrl,
    this.size = 66,
    this.radius = 4,
    this.fit = BoxFit.fill,
    this.defaultIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedImage(
        imageUrl: imageUrl ?? "",
        width: size,
        height: size,
        fit: fit,
        defaultIcon: defaultIcon,
      ),
    );
  }
}
