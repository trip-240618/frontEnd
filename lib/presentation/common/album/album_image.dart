import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class AlbumImage extends StatelessWidget {
  final AssetEntity image;
  final double? width;
  final double? height;
  final ThumbnailSize? thumbnailSize;
  final BoxFit? fit;

  const AlbumImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.thumbnailSize,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait = image.height > image.width;

    return AssetEntityImage(
      gaplessPlayback: true,
      filterQuality: FilterQuality.high,
      isOriginal: false,
      width: width ?? double.infinity,
      height: height,
      thumbnailSize: thumbnailSize ?? ThumbnailSize.square(500),
      thumbnailFormat: ThumbnailFormat.png,
      image,
      fit: fit ?? (isPortrait ? BoxFit.contain : BoxFit.cover),
    );
  }
}
