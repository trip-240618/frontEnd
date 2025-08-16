import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/dialog/loading.dart';
import 'package:tripStory/component/textForm/textform.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/core/util/color.dart';
import 'package:tripStory/core/util/font.dart';
import 'package:tripStory/presentation/trip/tripHistory/history/trip_history_list.dart';
import 'package:tripStory/presentation/trip/tripHistory/tag/tagAddPage.dart';

class TripHistoryAddPage extends StatefulWidget {
  const TripHistoryAddPage({super.key});

  @override
  State<TripHistoryAddPage> createState() => _TripHistoryAddPageState();
}

class _TripHistoryAddPageState extends State<TripHistoryAddPage> {
  final hs = Get.put(HistoryState());
  final ts = Get.put(TripState());
  List<TextEditingController> albumTextList = [];
  int selectIdx = 0;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    hs.addTagList.clear();
    for (int i = 0; i < hs.selectAlbumList.length; i++) {
      albumTextList.add(TextEditingController());
      hs.addTagList.add({});
    }
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in albumTextList) {
      controller.dispose();
    }
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: GestureDetector(
                    onTap: () {
                      hs.selectAlbumList.clear();
                      hs.addTagList.clear();
                      hs.albums.refresh();
                      Get.back();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: SvgPicture.asset(
                        'assets/icon/left_arrow.svg',
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  '사진 등록',
                  style: f16gray900w700,
                ),
                Spacer(),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${hs.selectAlbumList.length}',
                          style: f12gray900w500,
                        ),
                        Text(
                          '/${(50 - hs.historyTotalLen.value)}',
                          style: f12gray400w500,
                        ),
                      ],
                    ))
              ],
            ),
            backgroundColor: Colors.white,
          ),
          body: Obx(() => SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        hs.selectAlbumList.isNotEmpty
                            ? AssetEntityImage(
                                gaplessPlayback: true,
                                filterQuality: FilterQuality.high,
                                thumbnailSize: ThumbnailSize.square(700),
                                thumbnailFormat: ThumbnailFormat.png,
                                hs.selectAlbumList[selectIdx],
                                width: Get.width,
                                height: 360,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(),
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
                                  Color(0xff212121).withOpacity(0.5),
                                ],
                                stops: [0.3, 1],
                              ),
                            ),
                          ),
                        ),
                        hs.addTagList.isNotEmpty && hs.addTagList[selectIdx].isNotEmpty
                            ? Positioned(
                                bottom: 20,
                                left: 20,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.start,
                                  spacing: 12,
                                  children: hs.addTagList[selectIdx].map<Widget>((tag) {
                                    // 'tag'로 간단히 사용
                                    return Container(
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8, right: 7),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(color: gray200),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 16,
                                                      height: 16,
                                                      decoration: BoxDecoration(
                                                          color: tag['color'], // 태그 색깔
                                                          shape: BoxShape.circle),
                                                      child: Center(
                                                        child: Text('#',
                                                            style: tag['color'] == Color(0xffffffff)
                                                                ? f12gray900w500
                                                                : f12whitew500),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text('${tag['name']}', style: f12gray900w500), // 태그 이름
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                hs.addTagList[selectIdx].remove(tag); // 해당 태그 삭제
                                                hs.addTagList.refresh();
                                              },
                                              child: SvgPicture.asset(
                                                'assets/icon/minix.svg',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(), // 반드시 toList()로 변환
                                ),
                              )
                            : const SizedBox(),
                        hs.addTagList.isNotEmpty && hs.addTagList[selectIdx].length != 2
                            ? Positioned(
                                bottom: 20,
                                right: 20,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => TagAddPage(index: selectIdx))?.then((v) {
                                      focusNode.unfocus();
                                    });
                                  },
                                  child: Container(
                                    width: 77,
                                    height: 36,
                                    decoration: BoxDecoration(color: gray900, borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                        child: Text(
                                      '# 태그 추가',
                                      style: f12Whitew700,
                                    )),
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(() => Container(
                        width: Get.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width,
                                height: 70,
                                child: ReorderableListView.builder(
                                  itemCount: hs.selectAlbumList.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  onReorder: (int oldIndex, int newIndex) {
                                    if (newIndex > oldIndex) {
                                      newIndex -= 1;
                                    }
                                    final item = hs.selectAlbumList.removeAt(oldIndex);
                                    hs.selectAlbumList.insert(newIndex, item);
                                  },
                                  itemBuilder: (context, index) {
                                    return Row(
                                      key: ValueKey(hs.selectAlbumList[index]),
                                      children: [
                                        Container(
                                          width: 72,
                                          height: 70,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                bottom: 0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    selectIdx = index;
                                                    setState(() {});
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(4),
                                                    child: AssetEntityImage(
                                                      gaplessPlayback: true,
                                                      filterQuality: FilterQuality.high,
                                                      isOriginal: false,
                                                      width: 64,
                                                      height: 64,
                                                      thumbnailSize: ThumbnailSize.square(500),
                                                      thumbnailFormat: ThumbnailFormat.png,
                                                      hs.selectAlbumList[index],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: GestureDetector(
                                                  behavior: HitTestBehavior.opaque,
                                                  onTap: () {
                                                    if (hs.selectAlbumList.length != 1) {
                                                      hs.removeImage(hs.selectAlbumList[index], index);
                                                      albumTextList.removeAt(index);
                                                      if (selectIdx != 0) {
                                                        selectIdx--;
                                                      }
                                                      setState(() {});
                                                    }
                                                  },
                                                  child: SvgPicture.asset(
                                                    'assets/icon/minix.svg',
                                                    fit: BoxFit.contain,
                                                    width: 20,
                                                    height: 20,
                                                    alignment: Alignment.center,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 17,
                              ),
                              Container(
                                width: Get.width,
                                height: 108,
                                decoration: BoxDecoration(
                                  color: gray50,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: gray200),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: TextMemoFormFields(
                                        controller: albumTextList[selectIdx],
                                        hintText: '간단한 메모를 기록해 보세요',
                                        inputFormatters: [LengthLimitingTextInputFormatter(60)],
                                        scrollPadding:
                                            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 40),
                                        onChanged: (v) {
                                          setState(() {});
                                        },
                                      )),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${albumTextList[selectIdx].text.length}',
                                            style: albumTextList[selectIdx].text.length > 0
                                                ? f11Gray800w600
                                                : f11Gray400w600,
                                          ),
                                          Text(
                                            '/60 ',
                                            style: f11Gray400w600,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))),
                    SizedBox(height: 10),
                  ],
                ),
              )),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 44, left: 20, right: 20),
            child: BlackCountContainer(
                onTap: () async {
                  if (hs.selectAlbumList.length > 50 - hs.historyTotalLen.value) {
                    showOnlyConfirmTapDialog(context, '사진은 최대 50장까지 등록할 수 있습니다', () {
                      Get.back();
                    });
                  } else {
                    showLoading(context);
                    Timer.periodic(Duration(milliseconds: 500), (timer) async {
                      if (hs.uploadingLoading.value) {
                        hs.uploadingLoading.value = false;
                        timer.cancel();
                        List totalList = [];
                        for (int i = 0; i < hs.selectAlbumList.length; i++) {
                          totalList.add({
                            "thumbnail": "${hs.imgUrl[i].toString().split('?')[0]}",
                            "imageUrl": "${hs.imgUrl[i].toString().split('?')[0]}",
                            "latitude": hs.selectAlbumList[i].latitude,
                            "longitude": hs.selectAlbumList[i].longitude,
                            "photoDate": "${hs.selectedDate.value.toString().replaceAll(".", '-').split(' ')[0]}",
                            "memo": "${albumTextList[i].text}",
                            "tags": hs.addTagList[i].length == 0
                                ? []
                                : [
                                    for (var tag in hs.addTagList[i])
                                      {
                                        "tagColor": "${tag['color'].value.toRadixString(16).toUpperCase()}",
                                        "tagName": tag['name'],
                                      },
                                  ],
                          });
                        }

                        DateTime startDate = DateTime.parse(ts.selectTripList[0]['startDate']);
                        DateTime endDate = DateTime.parse(ts.selectTripList[0]['endDate']);

                        /// 날짜 목록 생성
                        List<String> dateList = [];
                        for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
                          dateList.add(DateFormat('yyyy-MM-dd').format(startDate.add(Duration(days: i))));
                        }
                        int index =
                            dateList.indexOf(hs.selectedDate.value.toString().replaceAll(".", '-').split(' ')[0]);
                        await hs.addHistory(ts.selectTripList[0]['id'], totalList);
                        Get.back();
                        Get.back();
                        Get.off(() => TripHistoryList(index: index));
                      }
                    });
                  }
                },
                title: '업로드',
                count: hs.selectAlbumList.length),
          ),
        ),
      ),
    );
  }
}
