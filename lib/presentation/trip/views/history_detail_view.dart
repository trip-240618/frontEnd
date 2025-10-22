import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/enum/text_edit_type.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/extension/date_extension.dart';
import 'package:tripStory/core/util/extension/string_extension.dart';
import 'package:tripStory/domain/entities/tag_entity.dart';
import 'package:tripStory/presentation/common/button/icon_button.dart';
import 'package:tripStory/presentation/common/empty_view.dart';
import 'package:tripStory/presentation/common/image/cached_image.dart';
import 'package:tripStory/presentation/common/popup/pop_up_menu.dart';
import 'package:tripStory/presentation/common/tag/tag.dart';
import 'package:tripStory/presentation/common/text/edit/edit_text_form_field.dart';
import 'package:tripStory/presentation/common/user/user_profile.dart';
import 'package:tripStory/presentation/trip/controllers/history_detail_controller.dart';

class HistoryDetailView extends StatefulWidget {
  const HistoryDetailView({super.key});

  @override
  State<HistoryDetailView> createState() => _HistoryDetailViewState();
}

class _HistoryDetailViewState extends State<HistoryDetailView> {
  final PageController pageController = PageController(initialPage: 0);
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<HistoryDetailController>(
        builder: (HistoryDetailController controller) {
          final state = controller.state;

          return Stack(
            children: [
              Positioned.fill(
                child: PageView.builder(
                  controller: pageController,
                  physics: const ClampingScrollPhysics(),
                  itemCount: state.historiesDetailLength,
                  onPageChanged: (v) {
                    // selectedPageIdx = v;
                  },
                  itemBuilder: (context, pageIdx) {
                    final historyDetailList = state.historyDetailEntities.values.toList();
                    final historyDetail = historyDetailList[pageIdx];

                    return Column(
                      children: [
                        Stack(
                          children: [
                            CachedImage(
                              imageUrl: historyDetail.imageUrl,
                              width: Get.width,
                              height: Get.height * 0.6,
                              fit: BoxFit.contain,
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      context.color.black.withValues(alpha: 0.3),
                                      context.color.black.withValues(alpha: 0.2),
                                      context.color.black.withValues(alpha: 0.1),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 50,
                              left: 20,
                              child: AppIconButton(
                                assetPath: IconConstants.leftArrow,
                                color: context.color.white,
                                onTap: () => Get.back(),
                              ),
                            ),
                            Positioned(
                              top: 50,
                              right: 20,
                              child: MultiPopUpMenu(
                                icon: IconConstants.moreHorizon,
                                iconColor: context.color.white,
                                items: [
                                  PopupMenuAction(
                                    title: "사진 공유",
                                    onTap: () => {},
                                    iconPath: IconConstants.chain,
                                  ),
                                  if (historyDetail.isWriter(controller.myUuid))
                                    PopupMenuAction(
                                      title: "게시물 삭제",
                                      onTap: () => {},
                                      iconPath: IconConstants.delete,
                                    ),
                                  PopupMenuAction(
                                    title: "게시물 신고",
                                    onTap: () => {},
                                    iconPath: IconConstants.declaration,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      context.color.black.withValues(alpha: 0.1),
                                      context.color.black.withValues(alpha: 0.2),
                                      context.color.black.withValues(alpha: 0.3),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              right: 20,
                              child: _ImageInfoSection(
                                imageUrl: historyDetail.imageUrl,
                                nickName: historyDetail.nickname,
                                photoDate: historyDetail.photoDate ?? DateTime.now(),
                                memo: historyDetail.memo ?? "",
                              ),
                            ),
                          ],
                        ),
                        if (historyDetail.tags?.isNotEmpty ?? false) _TagSection(tags: historyDetail.tags!),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: _HeartCommentSection(
                            likeCnt: historyDetail.likeCnt ?? 0,
                            replyCnt: historyDetail.replyCnt ?? 0,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: MediaQuery.of(context).viewInsets.bottom + 100,
                            ),
                            child: state.replies.isEmpty
                                ? EmptyView(
                                    content: "등록된 댓글이 없습니다\n댓글을 등록해 주세요",
                                  )
                                : ListView.separated(
                                    controller: controller.scrollController,
                                    shrinkWrap: true,
                                    itemCount: state.replies.length,
                                    padding: EdgeInsets.zero,
                                    separatorBuilder: (context, index) => const SizedBox(
                                      height: 16,
                                    ),
                                    itemBuilder: (context, index) {
                                      final reply = state.replies[index];
                                      return _ReplyItem(
                                        profileImage: reply.profileImage,
                                        nickName: reply.nickname,
                                        createDate: reply.createDate.timeAgo,
                                        content: reply.content,
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: MediaQuery.of(context).viewInsets.bottom,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: _focusNode.hasFocus ? 10 : 30,
                  ),
                  child: EditTextFormField(
                    controller: controller.textCon,
                    focusNode: _focusNode,
                    hintText: "댓글을 입력해주세요",
                    editType: TextEditType.button,
                    buttonText: "등록",
                    onTrailingPressed: () => controller.onCreateReplyPressed(),
                    onSubmit: (text) {},
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

class _ImageInfoSection extends StatelessWidget {
  final String imageUrl;
  final String nickName;
  final DateTime photoDate;
  final String memo;

  const _ImageInfoSection({
    required this.imageUrl,
    required this.nickName,
    required this.photoDate,
    required this.memo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            UserProfile(size: 24, thumbnailImage: imageUrl),
            const SizedBox(width: 8),
            Text(
              nickName,
              style: context.style.caption1.copyWith(color: context.color.white),
            ),
            const SizedBox(width: 4),
            Text(
              photoDate.formatShortYMD(),
              style: context.style.caption1.copyWith(
                fontWeight: FontWeight.w400,
                color: context.color.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (memo.isNotEmpty)
          Text(
            memo,
            style: context.style.body2Normal.copyWith(color: context.color.white),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}

class _TagSection extends StatelessWidget {
  final List<TagEntity> tags;

  const _TagSection({required this.tags});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: context.color.gray50,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        spacing: 12,
        children: tags.map<Widget>((tag) {
          return Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: Tag.hashtag(
              label: tag.tagName,
              leadingColor: tag.tagColor.toColor(),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _HeartCommentSection extends StatelessWidget {
  final int likeCnt;
  final int replyCnt;

  const _HeartCommentSection({
    required this.likeCnt,
    required this.replyCnt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppIconButton(
          assetPath: IconConstants.favorite,
          color: context.color.gray300,
          onTap: () {},
        ),
        Text(
          "$likeCnt",
          style: context.style.label1Reading,
        ),
        const SizedBox(width: 8),
        AppIconButton(
          assetPath: IconConstants.comment,
          color: context.color.gray900,
        ),
        Text(
          "$replyCnt",
          style: context.style.label1Reading,
        ),
      ],
    );
  }
}

class _ReplyItem extends StatelessWidget {
  final String profileImage;
  final String nickName;
  final String createDate;
  final String content;

  const _ReplyItem({
    required this.profileImage,
    required this.nickName,
    required this.createDate,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            UserProfile(
              size: 24,
              thumbnailImage: profileImage,
            ),
            const SizedBox(width: 8),
            Text(
              nickName,
              style: context.style.caption1,
            ),
            const SizedBox(width: 4),
            Text(
              createDate,
              style: context.style.caption1.copyWith(
                fontWeight: FontWeight.w400,
                color: context.color.gray400,
              ),
            ),
            Spacer(),
            MultiPopUpMenu(
              icon: IconConstants.moreHorizon,
              items: [
                PopupMenuAction(
                  title: "댓글 수정",
                  onTap: () => {},
                  iconPath: IconConstants.pencil,
                ),
                PopupMenuAction(
                  title: "댓글 삭제",
                  onTap: () => {},
                  iconPath: IconConstants.delete,
                ),
                PopupMenuAction(
                  title: "댓글 신고",
                  onTap: () => {},
                  iconPath: IconConstants.declaration,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: context.style.label1Normal.copyWith(
            color: context.color.gray800,
          ),
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
