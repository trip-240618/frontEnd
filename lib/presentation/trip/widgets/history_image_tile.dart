import 'package:flutter/material.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';
import 'package:tripStory/presentation/common/image/round_thumbnail_image.dart';
import 'package:tripStory/presentation/common/user/user_profile.dart';

class HistoryImageTile extends StatelessWidget {
  final String thumbnail;
  final String userThumbnail;
  final int likeCount;
  final int replyCount;
  final VoidCallback? onImagePressed;

  const HistoryImageTile({
    super.key,
    required this.thumbnail,
    required this.userThumbnail,
    required this.likeCount,
    required this.replyCount,
    this.onImagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImagePressed,
      child: SizedBox(
        width: 120,
        height: 150,
        child: Stack(
          children: [
            Positioned.fill(
              child: RoundThumbnailImage(
                key: key,
                imageUrl: thumbnail,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      context.color.gray900.withValues(alpha: 0.5),
                    ],
                    stops: [0.54, 1],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: UserProfile(
                size: 20,
                thumbnailImage: userThumbnail,
              ),
            ),
            Positioned(
              left: 8,
              bottom: 8,
              child: Row(
                children: [
                  SvgIcon(
                    assetPath: IconConstants.favorite,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    "$likeCount",
                    style: context.style.caption1.copyWith(
                      color: context.color.white,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SvgIcon(
                    assetPath: IconConstants.comment,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    "$replyCount",
                    style: context.style.caption1.copyWith(
                      color: context.color.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
