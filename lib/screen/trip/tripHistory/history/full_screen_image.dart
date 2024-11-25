import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../component/empty/emptyScreen.dart';

class FullScreenImage extends StatefulWidget {
  final String imageUrl;
  const FullScreenImage({super.key, required this.imageUrl});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            InteractiveViewer(
              panEnabled: true,
              minScale: 0.1,
              maxScale: 3.0,
              constrained: true,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  width: Get.width,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => const CircularProgressIndicator(),
                ),
              ),
            ),
            // 상단 딤 효과
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 120, // 상단 딤의 높이
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.1),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // 하단 딤 효과
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 120, // 하단 딤의 높이
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.3),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 24,height: 24,
                    child: SvgPicture.asset('assets/icon/xicon.svg',fit: BoxFit.fill,)),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
