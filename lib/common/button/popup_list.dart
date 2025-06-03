import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tripStory/common/model/popup_item_model.dart';

import '../../component/empty/emptyScreen.dart';
import '../../util/color.dart';
import '../../util/font.dart';

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
                      child: CachedNetworkImage(
                        width: 24,
                        height: 24,
                        imageUrl: member.profileImg ?? "",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => DefaultProfileScreen(context),
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
