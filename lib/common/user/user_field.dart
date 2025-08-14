import 'package:flutter/material.dart';
import 'package:tripStory/common/button/box/box_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/common/user/user_profile.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class UserField extends StatelessWidget {
  final String name;
  final String thumbnailImage;
  final bool isLeader;
  final bool isMe;
  final VoidCallback onTrailingPressed;

  const UserField({
    super.key,
    required this.name,
    required this.thumbnailImage,
    required this.isLeader,
    required this.isMe,
    required this.onTrailingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: Stack(
              children: [
                UserProfile(
                  size: 24,
                  thumbnailImage: thumbnailImage,
                ),
                if (isLeader) ...[
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SvgIcon(
                      assetPath: IconConstants.leader,
                    ),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          if (isMe) ...[
            SvgIcon(
              assetPath: IconConstants.meMark,
            ),
            const SizedBox(
              width: 4,
            ),
          ],
          Text(
            name,
            style: context.style.body2Normal,
          ),
          Spacer(),
          if (isLeader && !isMe) ...[
            BoxButton(
              label: "내보내기",
              onPressed: onTrailingPressed,
            ),
          ],
        ],
      ),
    );
  }
}
