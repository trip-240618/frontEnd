import 'package:flutter/material.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/image/round_thumbnail_image.dart';
import 'package:tripStory/presentation/global/global_context.dart';

class HistoryMapMarker extends StatelessWidget {
  final String imageUrl;
  final int count;

  const HistoryMapMarker({
    super.key,
    required this.imageUrl,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final context = GlobalContext.navigatorKey.currentContext;
    return SizedBox(
      width: 300,
      height: 400,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: context?.color.gray900,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Center(
                    child: Text(
                      "$count",
                      style: context?.style.caption1.copyWith(
                        fontSize: 28,
                        color: context.color.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Image.asset(
                IconConstants.historyMarker,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 98,
              left: 45,
              right: 45,
              top: 95,
              child: RoundThumbnailImage(
                size: 280,
                imageUrl: imageUrl,
                radius: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
