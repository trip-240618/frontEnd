import 'package:flutter/material.dart';
import 'package:tripStory/common/image/round_thumbnail_image.dart';
import 'package:tripStory/common/model/popup_item_model.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';

class PopupList extends StatelessWidget {
  final List<PopupItemModel> members;

  const PopupList({
    super.key,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: members.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, idx) {
        final member = members[idx];
        return SizedBox(
          height: 50,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 12,
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: RoundThumbnailImage(
                        imageUrl: member.profileImg ?? "",
                        size: 24,
                        errorIcon: IconConstants.defaultPerson,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        member.nickname,
                        style: f14Gray800w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Divider(color: gray200, height: 5),
            ],
          ),
        );
      },
    );
  }
}
