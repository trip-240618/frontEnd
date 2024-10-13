import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 원형 캐시드네트워크 이미지
class CircleImage extends StatelessWidget {
  final String imageUrl;
  final double size;
  final VoidCallback onTap;

  const CircleImage({Key? key,
    required this.imageUrl,
    required this.size,
    required this.onTap,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill
                ),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
