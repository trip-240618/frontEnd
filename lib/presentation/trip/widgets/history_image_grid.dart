import 'package:flutter/material.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/presentation/trip/widgets/history_image_tile.dart';

class HistoryImageGrid extends StatelessWidget {
  final VoidCallback onImagePressed;
  final List<HistoryEntity> histories;

  const HistoryImageGrid({
    super.key,
    required this.onImagePressed,
    required this.histories,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 0.793,
      ),
      itemCount: histories.length,
      itemBuilder: (context, index) {
        final history = histories[index];

        return HistoryImageTile(
          thumbnail: history.thumbnail,
          userThumbnail: history.profileImage ?? "",
          likeCount: history.likeCnt ?? 0,
          replyCount: history.replyCnt ?? 0,
          onImagePressed: onImagePressed,
        );
      },
    );
  }
}
