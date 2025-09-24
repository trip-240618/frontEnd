import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/helper/text_span_helper.dart';
import 'package:tripStory/presentation/common/album/album_image.dart';
import 'package:tripStory/presentation/common/appbar/app_appbar.dart';
import 'package:tripStory/presentation/common/button/bottom/bottom_button.dart';
import 'package:tripStory/presentation/common/button/box/box_button.dart';
import 'package:tripStory/presentation/common/button/icon_button.dart';
import 'package:tripStory/presentation/common/icon/round_icon.dart';
import 'package:tripStory/presentation/common/tag/tag.dart';
import 'package:tripStory/presentation/common/text/area/text_area_form_field.dart';
import 'package:tripStory/presentation/trip/controllers/history_create_controller.dart';
import 'package:tripStory/presentation/trip/models/history_create_state.dart';

class HistoryCreateView extends StatefulWidget {
  final List<AssetEntity> images;

  const HistoryCreateView({
    super.key,
    required this.images,
  });

  @override
  State<HistoryCreateView> createState() => _HistoryCreateViewState();
}

class _HistoryCreateViewState extends State<HistoryCreateView> {
  final controller = Get.find<HistoryCreateController>();

  @override
  void initState() {
    super.initState();
    controller.init(widget.images);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder<HistoryCreateController>(
        builder: (controller) {
          final state = controller.state;

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
              onTap: () {},
            ),
            // bottomNavigationBar: Padding(
            //   padding: const EdgeInsets.only(bottom: 44, left: 20, right: 20),
            //   child: BlackCountContainer(
            //       onTap: () async {
            //         if (hs.selectAlbumList.length > 50 - hs.historyTotalLen.value) {
            //           showOnlyConfirmTapDialog(context, '사진은 최대 50장까지 등록할 수 있습니다', () {
            //             Get.back();
            //           });
            //         } else {
            //           showLoading(context);
            //           Timer.periodic(Duration(milliseconds: 500), (timer) async {
            //             if (hs.uploadingLoading.value) {
            //               hs.uploadingLoading.value = false;
            //               timer.cancel();
            //               List totalList = [];
            //               for (int i = 0; i < hs.selectAlbumList.length; i++) {
            //                 totalList.add({
            //                   "thumbnail": "${hs.imgUrl[i].toString().split('?')[0]}",
            //                   "imageUrl": "${hs.imgUrl[i].toString().split('?')[0]}",
            //                   "latitude": hs.selectAlbumList[i].latitude,
            //                   "longitude": hs.selectAlbumList[i].longitude,
            //                   "photoDate": "${hs.selectedDate.value.toString().replaceAll(".", '-').split(' ')[0]}",
            //                   "memo": "${albumTextList[i].text}",
            //                   "tags": hs.addTagList[i].length == 0
            //                       ? []
            //                       : [
            //                           for (var tag in hs.addTagList[i])
            //                             {
            //                               "tagColor": "${tag['color'].value.toRadixString(16).toUpperCase()}",
            //                               "tagName": tag['name'],
            //                             },
            //                         ],
            //                 });
            //               }
            //
            //               DateTime startDate = DateTime.parse(ts.selectTripList[0]['startDate']);
            //               DateTime endDate = DateTime.parse(ts.selectTripList[0]['endDate']);
            //
            //               /// 날짜 목록 생성
            //               List<String> dateList = [];
            //               for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
            //                 dateList.add(DateFormat('yyyy-MM-dd').format(startDate.add(Duration(days: i))));
            //               }
            //               int index =
            //                   dateList.indexOf(hs.selectedDate.value.toString().replaceAll(".", '-').split(' ')[0]);
            //               await hs.addHistory(ts.selectTripList[0]['id'], totalList);
            //               Get.back();
            //               Get.back();
            //               Get.off(() => TripHistoryList(index: index));
            //             }
            //           });
            //         }
            //       },
            //       title: '업로드',
            //       count: hs.selectAlbumList.length),
            // ),
          );
        },
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final PageController pageController;
  final List<HistoryItem> historyItems;
  final Function(int) onPageChanged;
  final Function(int) onTagDeletedPressed;

  const _ImageViewer({
    required this.pageController,
    required this.historyItems,
    required this.onTagDeletedPressed,
    required this.onPageChanged,
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
          // final currentTags = index < tags.length ? tags[index] : <TagEntity>[];
          // final image = images[index];

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
                              leadingColor: context.color.blue,
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
                visible: !historyItem.tags.isNotEmpty,
                child: Positioned(
                  bottom: 20,
                  right: 20,
                  child: BoxButton(
                    label: "# 태그 추가",
                    height: 36,
                    borderRadius: 4,
                    onPressed: () {},
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
