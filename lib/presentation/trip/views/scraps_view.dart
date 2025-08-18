import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/empty/emptyScreen.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/extension/date_extension.dart';
import 'package:tripStory/core/util/extension/string_extension.dart';
import 'package:tripStory/presentation/common/button/icon_button.dart';
import 'package:tripStory/presentation/common/dialog/common_dialog.dart';
import 'package:tripStory/presentation/common/divider/common_divider.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';
import 'package:tripStory/presentation/trip/controllers/scraps_controller.dart';
import 'package:tripStory/presentation/trip/models/scraps_state.dart';

class ScrapsView extends StatelessWidget {
  const ScrapsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.gray50,
      body: GetBuilder<ScrapsController>(
        builder: (controller) {
          final status = controller.state.status;

          if (status == ScrapsStatus.initial) {
            return const SizedBox.shrink();
          }
          if (status == ScrapsStatus.empty) {
            return const EmptyScreen(
              content: "여행에 필요한 정보를\n스크랩 해보세요 :)",
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppIconButton(
                      onTap: () => controller.onBookmarkFilterPressed(),
                      assetPath: controller.state.isBookmarked
                          ? IconConstants.smallRoundCheckOn
                          : IconConstants.smallRoundCheckOff,
                    ),
                    Text(
                      "북마크",
                      style: context.style.caption1.copyWith(fontWeight: FontWeight.w600),
                    )
                  ],
                ),

                ///북마크 자리
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: MasonryGridView.count(
                    physics: const ClampingScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    itemCount: controller.state.length,
                    itemBuilder: (context, index) {
                      final scrap = controller.state.scraps[index];

                      return _ScrapCard(
                        dateText: scrap.createDate.formatYMDWithDot(),
                        cardColor: scrap.color.toColor(),
                        hasImage: scrap.hasImage,
                        title: scrap.title,
                        previewText: controller.jsonToPlainText(scrap.preview),
                        nickname: scrap.nickname,
                        isBookmarked: scrap.bookmark,
                        isMine: controller.isMine(scrap),
                        onTap: () {
                          // 수정/뷰어 페이지 라우팅
                        },
                        onBookmarkTap: () => controller.onBookmarkScrapPressed(scrap.id),
                        onDeleteTap: () => _showScrapDeleteDialog(
                          () => controller.onDeleteScrapPressed(scrap.id),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ScrapCard extends StatelessWidget {
  const _ScrapCard({
    required this.dateText,
    required this.cardColor,
    required this.hasImage,
    required this.title,
    required this.previewText,
    required this.nickname,
    required this.isBookmarked,
    required this.isMine,
    required this.onTap,
    required this.onBookmarkTap,
    required this.onDeleteTap,
  });

  final String dateText;
  final Color cardColor;
  final bool hasImage;
  final String title;
  final String previewText;
  final String nickname;
  final bool isBookmarked;
  final bool isMine;
  final VoidCallback onTap;
  final VoidCallback onBookmarkTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.color.gray200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ScrapCardHeader(
              dateText: dateText,
              cardColor: cardColor,
              isBookmarked: isBookmarked,
              onBookmarkTap: onBookmarkTap,
            ),
            const CommonDivider(),
            _ScrapCardContent(
              hasImage: hasImage,
              title: title,
              previewText: previewText,
            ),
            _ScrapCardFooter(
              nickname: nickname,
              isMine: isMine,
              onDeleteTap: onDeleteTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _ScrapCardHeader extends StatelessWidget {
  const _ScrapCardHeader({
    required this.dateText,
    required this.cardColor,
    required this.isBookmarked,
    required this.onBookmarkTap,
  });

  final String dateText;
  final Color cardColor;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          AppIconButton(
            assetPath: isBookmarked ? IconConstants.bookmarkOn : IconConstants.bookmarkOff,
            width: 20,
            height: 20,
            onTap: onBookmarkTap,
          ),
          Text(
            dateText,
            style: context.style.caption2.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrapCardContent extends StatelessWidget {
  const _ScrapCardContent({
    required this.hasImage,
    required this.title,
    required this.previewText,
  });

  final bool hasImage;
  final String title;
  final String previewText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasImage) ...[
            SvgIcon(
              assetPath: IconConstants.photo,
              color: context.color.gray900,
              width: 20,
              height: 20,
            ),
            const SizedBox(height: 4),
          ],
          Text(
            title,
            style: context.style.label1Normal.copyWith(fontWeight: FontWeight.w700),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            previewText,
            style: context.style.caption1.copyWith(fontWeight: FontWeight.w500),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ScrapCardFooter extends StatelessWidget {
  const _ScrapCardFooter({
    required this.nickname,
    required this.isMine,
    required this.onDeleteTap,
  });

  final String nickname;
  final bool isMine;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 4, bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                nickname,
                style: context.style.caption2.copyWith(
                  fontWeight: FontWeight.w400,
                  color: context.color.gray600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isMine)
              AppIconButton(
                assetPath: IconConstants.delete,
                color: context.color.gray900,
                onTap: onDeleteTap,
              ),
          ],
        ),
      ),
    );
  }
}

void _showScrapDeleteDialog(
  VoidCallback onConfirmPressed,
) {
  CommonDialog.show(
    title: "스크랩을 삭제하시겠습니까?",
    message: "스크랩 삭제 후 복구는 어렵습니다",
    confirmText: "확인",
    onConfirm: onConfirmPressed,
  );
}
