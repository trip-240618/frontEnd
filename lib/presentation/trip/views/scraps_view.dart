import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/empty/emptyScreen.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/extension/date_extension.dart';
import 'package:tripStory/core/util/extension/string_extension.dart';
import 'package:tripStory/core/util/helper/quill_helper.dart';
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
          return Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BookmarkFilter(
                  isSelected: controller.state.showBookmarkedOnly,
                  onTap: () => controller.onBookmarkFilterPressed(),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: status == ScrapsStatus.empty
                      ? const EmptyScreen(
                          content: "여행에 필요한 정보를\n스크랩 해보세요 :)",
                        )
                      : MasonryGridView.count(
                          physics: const ClampingScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          itemCount: controller.state.scraps.length,
                          itemBuilder: (context, index) {
                            final scrap = controller.state.scraps[index];
                            return GestureDetector(
                              onTap: () {
                                // TODO : 수정 페이지/뷰어 페이지로 이동하는 라우터 추가 예정
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: Get.width,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: scrap.color.toColor(),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                      border: Border.all(color: context.color.gray200),
                                    ),
                                    child: Row(
                                      children: [
                                        AppIconButton(
                                          assetPath: scrap.bookmark
                                              ? "assets/icon/checkBookmark.svg"
                                              : "assets/icon/bookmark.svg",
                                          width: 20,
                                          height: 20,
                                          onTap: () => controller.onBookmarkScrapPressed(scrap.id),
                                        ),
                                        Text(
                                          scrap.createDate.formatYMDWithDot(),
                                          style: context.style.caption2.copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(color: context.color.gray200),
                                        right: BorderSide(color: context.color.gray200),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (!scrap.hasImage)
                                          SvgIcon(
                                            assetPath: IconConstants.photo,
                                            color: context.color.gray900,
                                            width: 20,
                                            height: 20,
                                          ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          scrap.title,
                                          style: context.style.label1Normal.copyWith(fontWeight: FontWeight.w700),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          controller.jsonToPlainText(scrap.preview),
                                          style: context.style.caption1.copyWith(fontWeight: FontWeight.w500),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.only(left: 10, right: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                      border: Border(
                                        left: BorderSide(color: context.color.gray200),
                                        right: BorderSide(color: context.color.gray200),
                                        bottom: BorderSide(color: context.color.gray200),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          scrap.nickname,
                                          style: context.style.caption2
                                              .copyWith(fontWeight: FontWeight.w400, color: context.color.gray600),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Spacer(),
                                        if (controller.isMine(scrap))
                                          AppIconButton(
                                            assetPath: IconConstants.delete,
                                            color: context.color.gray900,
                                            onTap: () => _showScrapDeleteDialog(
                                              () => controller.onDeleteScrapPressed(scrap.id),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
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

class _BookmarkFilter extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const _BookmarkFilter({
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIconButton(
          assetPath: isSelected ? IconConstants.smallRoundCheck : IconConstants.smallRoundOff,
          width: 20,
          height: 20,
          onTap: onTap,
        ),
        Text(
          "북마크",
          style: context.style.caption1.copyWith(fontWeight: FontWeight.w600, color: context.color.gray600),
        )
      ],
    );
  }
}

class _ScrapsContent extends StatelessWidget {
  final ScrapsController controller;
  final ScrapsStatus status;

  const _ScrapsContent({
    required this.controller,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      ScrapsStatus.loading => const SizedBox.shrink(),
      ScrapsStatus.failure => const Center(child: Text('오류가 발생했습니다')),
      ScrapsStatus.empty => const EmptyScreen(
          content: "여행에 필요한 정보를\n스크랩 해보세요 :)",
        ),
      ScrapsStatus.success => MasonryGridView.count(
          physics: const ClampingScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          itemCount: controller.state.scraps.length,
          itemBuilder: (BuildContext context, int index) {
            final scrap = controller.state.scraps[index];
            return GestureDetector(
              onTap: () {
                // TODO : 수정 페이지/뷰어 페이지로 이동하는 라우터 추가 예정
              },
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    height: 40,
                    decoration: BoxDecoration(
                      color: scrap.color.toColor(),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      border: Border.all(color: context.color.gray200),
                    ),
                    child: Row(
                      children: [
                        AppIconButton(
                          assetPath: scrap.bookmark ? "assets/icon/checkBookmark.svg" : "assets/icon/bookmark.svg",
                          width: 20,
                          height: 20,
                          onTap: () => controller.onBookmarkScrapPressed(scrap.id),
                        ),
                        Text(
                          scrap.createDate.formatYMDWithDot(),
                          style: context.style.caption2.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: context.color.gray200),
                        right: BorderSide(color: context.color.gray200),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!scrap.hasImage)
                          SvgIcon(
                            assetPath: IconConstants.photo,
                            color: context.color.gray900,
                            width: 20,
                            height: 20,
                          ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          scrap.title,
                          style: context.style.label1Normal.copyWith(fontWeight: FontWeight.w700),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          controller.jsonToPlainText(scrap.preview),
                          style: context.style.caption1.copyWith(fontWeight: FontWeight.w500),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.only(left: 10, right: 4, bottom: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      border: Border(
                        left: BorderSide(color: context.color.gray200),
                        right: BorderSide(color: context.color.gray200),
                        bottom: BorderSide(color: context.color.gray200),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scrap.nickname,
                          style: context.style.caption2
                              .copyWith(fontWeight: FontWeight.w400, color: context.color.gray600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        if (controller.isMine(scrap))
                          AppIconButton(
                            assetPath: IconConstants.delete,
                            color: context.color.gray900,
                            onTap: () => _showScrapDeleteDialog(
                              () => controller.onDeleteScrapPressed(scrap.id),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

void _showScrapDeleteDialog(
  VoidCallback onConfirmPressed,
) {
  CommonDialog.showConfirmCancel(
    title: "스크랩을 삭제하시겠습니까?",
    message: "스크랩 삭제 후 복구는 어렵습니다",
    confirmText: "확인",
    onConfirm: onConfirmPressed,
  );
}
