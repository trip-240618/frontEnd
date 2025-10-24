import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/enum/text_edit_type.dart';
import 'package:tripStory/core/enum/trip_color.dart';
import 'package:tripStory/core/util/extension/color_extension.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/extension/string_extension.dart';
import 'package:tripStory/core/util/helper/text_span_helper.dart';
import 'package:tripStory/domain/entities/tag_entity.dart';
import 'package:tripStory/presentation/common/album/album_image.dart';
import 'package:tripStory/presentation/common/appbar/app_appbar.dart';
import 'package:tripStory/presentation/common/bottom/base_bottom_sheet.dart';
import 'package:tripStory/presentation/common/button/bottom/bottom_button.dart';
import 'package:tripStory/presentation/common/button/box/box_button.dart';
import 'package:tripStory/presentation/common/button/color_select_button.dart';
import 'package:tripStory/presentation/common/button/icon_button.dart';
import 'package:tripStory/presentation/common/dialog/common_dialog.dart';
import 'package:tripStory/presentation/common/dialog/loading_dialog.dart';
import 'package:tripStory/presentation/common/icon/round_icon.dart';
import 'package:tripStory/presentation/common/tag/tag.dart';
import 'package:tripStory/presentation/common/text/area/text_area_form_field.dart';
import 'package:tripStory/presentation/common/text/edit/edit_text_form_field.dart';
import 'package:tripStory/presentation/trip/controllers/history_create_controller.dart';
import 'package:tripStory/presentation/trip/models/history_create_param.dart';
import 'package:tripStory/presentation/trip/models/history_create_state.dart';

class HistoryCreateView extends StatefulWidget {
  final HistoryCreateParam historyCreateParam;

  const HistoryCreateView({
    super.key,
    required this.historyCreateParam,
  });

  @override
  State<HistoryCreateView> createState() => _HistoryCreateViewState();
}

class _HistoryCreateViewState extends State<HistoryCreateView> {
  final controller = Get.find<HistoryCreateController>();

  @override
  void initState() {
    super.initState();
    controller.init(widget.historyCreateParam.images);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder<HistoryCreateController>(
        builder: (controller) {
          final state = controller.state;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            final showMaxUploadDialog = state.showMaxUploadDialog?.consume() ?? false;
            final showLoadingDialog = state.showLoadingDialog?.consume() ?? false;
            if (showMaxUploadDialog) {
              _showMaxDialog();
            }
            if (showLoadingDialog) {
              _showLoadingDialog();
            }
          });

          return Scaffold(
            appBar: AppAppbar(
              text: "사진 등록",
              actionWidget: Text.rich(
                TextSpanHelper.toSplitText(
                  text: "${state.historyLength} / 50",
                  delimiter: "/",
                  firstStyle: context.style.caption1.copyWith(
                    color: context.color.gray900,
                  ),
                  secondStyle: context.style.caption1.copyWith(
                    color: context.color.gray400,
                  ),
                  delimiterStyle: context.style.caption1.copyWith(
                    color: context.color.gray400,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  _ImageViewer(
                    pageController: controller.pageController,
                    historyItems: state.historyItems,
                    onTagDeletedPressed: (index) => controller.onTagDeletedPressed(index),
                    onPageChanged: (_) => controller.onPageChanged(),
                    onTagAddPressed: () => _showTagBottomModal(
                      context,
                      tags: state.historyItems[controller.currentIndex].tags,
                      onSavePressed: (tags) => controller.onTagSavePressed(tags),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  _ImageList(
                    images: state.images,
                    onImageReorder: (int oldIndex, int newIndex) => controller.onReorderImages(oldIndex, newIndex),
                    onReorderImagePressed: (index) => controller.onReorderImagePressed(index),
                    onReorderImageDeleted: (index) => controller.onReorderImageDeleted(index),
                  ),
                  SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextAreaFormField(
                      controller: controller.memoCon,
                      height: 180,
                      hintText: "간단한 메모를 기록해 보세요",
                      backgroundColor: context.color.gray50,
                      contentPadding: const EdgeInsets.all(16),
                      maxTextLength: 100,
                      onChanged: (text) => controller.onMemoChanged(text),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100),
                      ],
                      keyboardType: TextInputType.multiline,
                      scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 44),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomButton(
              text: "업로드",
              trailingIcon: RoundIcon.number(
                number: state.historyLength,
                backgroundColor: context.color.white,
              ),
              onTap: () => controller.onHistoryUploadPressed(
                widget.historyCreateParam.photoDate ?? DateTime.now(),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showTagBottomModal(
    BuildContext context, {
    required List<TagEntity> tags,
    required ValueChanged<List<TagEntity>> onSavePressed,
  }) {
    BaseBottomSheet.show(
      context,
      _TagBottomModal(
        tags: tags,
        onSavePressed: (tags) => onSavePressed(tags),
      ),
      heightRatio: 0.65,
    );
  }

  void _showMaxDialog() {
    CommonDialog.showConfirm(
      title: "사진은 최대 50장까지 등록할 수 있습니다",
      onConfirm: () => Get.back(),
    );
  }

  void _showLoadingDialog() {
    LoadingDialog.show();
  }
}

class _ImageViewer extends StatelessWidget {
  final PageController pageController;
  final List<HistoryItem> historyItems;
  final Function(int) onPageChanged;
  final Function(int) onTagDeletedPressed;
  final VoidCallback onTagAddPressed;

  const _ImageViewer({
    required this.pageController,
    required this.historyItems,
    required this.onTagDeletedPressed,
    required this.onPageChanged,
    required this.onTagAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: PageView.builder(
        controller: pageController,
        itemCount: historyItems.length,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          final historyItem = historyItems[index];

          return Stack(
            children: [
              AlbumImage(
                image: historyItem.image,
                thumbnailSize: ThumbnailSize.square(700),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        context.color.gray900.withValues(alpha: 0.5),
                      ],
                      stops: [0.3, 1],
                    ),
                  ),
                ),
              ),
              if (historyItem.tags.isNotEmpty)
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    spacing: 12,
                    children: historyItem.tags.map<Widget>((tag) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16, right: 16),
                            child: Tag.hashtag(
                              label: tag.tagName,
                              leadingColor: tag.tagColor.toColor(),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: AppIconButton(
                              onTap: () => onTagDeletedPressed(index),
                              assetPath: IconConstants.smallClear,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              Visibility(
                visible: historyItem.tags.length < 2,
                child: Positioned(
                  bottom: 20,
                  right: 20,
                  child: BoxButton(
                    label: "# 태그 추가",
                    height: 36,
                    borderRadius: 4,
                    onPressed: onTagAddPressed,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ImageList extends StatelessWidget {
  final List<AssetEntity> images;
  final ReorderCallback onImageReorder;
  final Function(int) onReorderImagePressed;
  final Function(int) onReorderImageDeleted;

  const _ImageList({
    required this.images,
    required this.onImageReorder,
    required this.onReorderImagePressed,
    required this.onReorderImageDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width,
            height: 76,
            child: ReorderableListView.builder(
              itemCount: images.length,
              scrollDirection: Axis.horizontal,
              onReorder: onImageReorder,
              proxyDecorator: (child, index, animation) {
                return Material(
                  color: Colors.transparent,
                  elevation: 0,
                  child: child,
                );
              },
              itemBuilder: (context, index) {
                final image = images[index];
                return SizedBox(
                  key: ValueKey(image.id),
                  width: 78,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () => onReorderImagePressed(index),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: AlbumImage(
                              image: image,
                              width: 64,
                              height: 64,
                              thumbnailSize: ThumbnailSize.square(500),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: AppIconButton(
                          onTap: () => onReorderImageDeleted(index),
                          assetPath: IconConstants.smallClear,
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
  }
}

class _TagBottomModal extends StatefulWidget {
  final ValueChanged<List<TagEntity>> onSavePressed;
  final List<TagEntity> tags;

  const _TagBottomModal({
    required this.onSavePressed,
    required this.tags,
  });

  @override
  State<_TagBottomModal> createState() => _TagBottomModalState();
}

class _TagBottomModalState extends State<_TagBottomModal> {
  final TextEditingController _tagCon = TextEditingController();
  late final FocusNode _focusNode;
  late List<TagEntity> _tagList;
  TripColor _selectedTripColor = TripColor.pastelBlue;

  @override
  void initState() {
    super.initState();
    setState(() {
      _tagList = List<TagEntity>.from(widget.tags);
    });
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) _selectedTripColor = TripColor.pastelBlue;
        setState(() {});
      });
  }

  void onSelectedColorPressed(TripColor selectedColor) {
    setState(() {
      _selectedTripColor = selectedColor;
    });
  }

  void onTagAddPressed(String tagName) {
    if (_tagList.length >= 2 || tagName.isEmpty) return;
    final tagItem = TagEntity(
      tagColor: _selectedTripColor.color.toJson(),
      tagName: tagName,
    );
    setState(() {
      _tagList.add(tagItem);
    });
    _tagCon.clear();
  }

  void onTagDeletedPressed(int deleteIndex) {
    setState(() {
      _tagList.removeAt(deleteIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 27,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditTextFormField(
                controller: _tagCon,
                focusNode: _focusNode,
                hintText: "태그는 2개까지 등록 가능합니다",
                inputFormatters: [
                  LengthLimitingTextInputFormatter(7),
                ],
                editType: TextEditType.next,
                countText: "${_tagCon.text.length}/7",
                isFocusOnTapOutside: false,
                onChanged: (text) => setState(() {}),
                onTrailingPressed: () => onTagAddPressed(_tagCon.text),
                onSubmit: (text) => onTagAddPressed(text),
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                spacing: 4,
                children: _tagList.asMap().entries.map<Widget>((tag) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, right: 16),
                        child: Tag.hashtag(
                          label: tag.value.tagName,
                          leadingColor: tag.value.tagColor.toColor(),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: AppIconButton(
                          onTap: () => onTagDeletedPressed(tag.key),
                          assetPath: IconConstants.smallClear,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const Spacer(),
              SizedBox(
                width: Get.width,
                child: BottomButton(
                  padding: EdgeInsets.zero,
                  text: "저장",
                  enabled: _tagList.isNotEmpty,
                  onTap: () {
                    widget.onSavePressed(_tagList);
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
        if (_focusNode.hasFocus)
          AnimatedPositioned(
            curve: Curves.easeOutCubic,
            left: 0,
            right: 0,
            bottom: keyboardHeight - 45,
            duration: const Duration(microseconds: 200),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (!_focusNode.hasFocus) {
                  FocusScope.of(context).requestFocus(_focusNode);
                }
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: context.color.white,
                  boxShadow: [
                    BoxShadow(
                      color: context.color.shadow.withValues(alpha: 0.10),
                      offset: const Offset(0, -3),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: context.color.shadow.withValues(alpha: 0.09),
                      offset: const Offset(0, -10),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: context.color.shadow.withValues(alpha: 0.05),
                      offset: const Offset(0, -23),
                      blurRadius: 14,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: context.color.shadow.withValues(alpha: 0.01),
                      offset: const Offset(0, -40),
                      blurRadius: 16,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: context.color.shadow.withValues(alpha: 0.0),
                      offset: const Offset(0, -63),
                      blurRadius: 18,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: ColorSelectButton(
                    selectedColor: _selectedTripColor,
                    onSelected: (tripColor) => onSelectedColorPressed(tripColor),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _tagCon.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
