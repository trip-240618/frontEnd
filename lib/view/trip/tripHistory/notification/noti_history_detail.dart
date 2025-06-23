import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/textForm/textform.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/controller/userState.dart';

import '../../../../component/empty/emptyScreen.dart';
import '../../../../controller/historyState.dart';
import '../../../../controller/notificationState.dart';
import '../../../../controller/reportState.dart';
import '../../../../util/color.dart';
import '../../../../util/file_utils.dart';
import '../../../../util/font.dart';
import '../history/full_screen_image.dart';

class NotiHistoryDetail extends StatefulWidget {
  final int tripId;
  final int historyId;

  const NotiHistoryDetail({super.key, required this.tripId, required this.historyId});

  @override
  State<NotiHistoryDetail> createState() => _NotiHistoryDetailState();
}

class _NotiHistoryDetailState extends State<NotiHistoryDetail> {
  final hs = Get.put(HistoryState());
  final ts = Get.put(TripState());
  final us = Get.put(UserState());
  final notis = Get.put(NotiState());
  final rs = Get.put(ReportState());
  TextEditingController textCon = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isEditing = false;
  int? editingIdx;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    setState(() {});
    Future.delayed(Duration.zero, () async {
      notis.getNotificationComment(widget.tripId, widget.historyId);
    });
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 300), () {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    textCon.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        textCon.text = '';
        isEditing = false;
        setState(() {});
      },
      child: Scaffold(
        body: Obx(() => SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: notis.notificationHistory.length == 0
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(
                        bottom: _focusNode.hasFocus ? 30 : 0, // 키보드 높이 추가
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => FullScreenImage(imageUrl: notis.notificationHistory['imageUrl']));
                                },
                                child: CachedNetworkImage(
                                  imageUrl: '${notis.notificationHistory['imageUrl']}',
                                  width: Get.width,
                                  height: Get.height * 0.6,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) => DefaultProfileScreen(context),
                                ),
                              ),

                              /// 상단 딤
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
                              Positioned(
                                  top: 30,
                                  left: 0,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: SvgPicture.asset('assets/icon/left_arrow.svg',
                                          fit: BoxFit.none,
                                          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                                    ),
                                  )),
                              us.userList[0].uuid == notis.notificationHistory['writerUuid']
                                  ? Positioned(
                                      top: 30,
                                      right: 20,
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {},
                                        child: PopupMenuButton<int>(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          offset: const Offset(-10, 40),
                                          padding: EdgeInsets.zero,
                                          menuPadding: EdgeInsets.zero,
                                          shadowColor: Colors.black.withOpacity(0.4),
                                          icon: Container(
                                            height: 30,
                                            width: 30,
                                            alignment: Alignment.centerRight,
                                            child: SvgPicture.asset(
                                              'assets/icon/dot.svg',
                                              height: 30,
                                              width: 20,
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                            ),
                                          ),
                                          color: gray50,
                                          itemBuilder: (context) => <PopupMenuEntry<int>>[
                                            PopupMenuItem<int>(
                                              onTap: () async {
                                                await shareImage('${notis.notificationHistory['thumbnail']}');
                                              },
                                              padding: EdgeInsets.zero,
                                              value: 1,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 12, right: 12),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/icon/link.svg',
                                                          colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                          fit: BoxFit.none,
                                                        ),
                                                        const SizedBox(width: 10),
                                                        Text(
                                                          '사진 공유',
                                                          style: f12Gray800w600,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  : Positioned(
                                      top: 30,
                                      right: 20,
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          print('dasd');
                                        },
                                        child: PopupMenuButton<int>(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          offset: const Offset(-10, 40),
                                          padding: EdgeInsets.zero,
                                          menuPadding: EdgeInsets.zero,
                                          shadowColor: Colors.black.withOpacity(0.4),
                                          icon: Container(
                                            height: 30,
                                            width: 30,
                                            alignment: Alignment.centerRight,
                                            child: SvgPicture.asset(
                                              'assets/icon/dot.svg',
                                              height: 30,
                                              width: 20,
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                            ),
                                          ),
                                          color: gray50,
                                          itemBuilder: (context) => <PopupMenuEntry<int>>[
                                            PopupMenuItem<int>(
                                              onTap: () async {
                                                await shareImage('${notis.notificationHistory['thumbnail']}');
                                              },
                                              padding: EdgeInsets.zero,
                                              value: 1,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 12, right: 12),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/icon/link.svg',
                                                          colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                          fit: BoxFit.none,
                                                        ),
                                                        const SizedBox(width: 10),
                                                        Text(
                                                          '사진 공유',
                                                          style: f12Gray800w600,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const PopupMenuDivider(height: 1),
                                            PopupMenuItem<int>(
                                              onTap: () async {
                                                await rs.addReport('history', null, notis.notificationHistory['id']);
                                              },
                                              padding: EdgeInsets.zero,
                                              value: 3,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icon/siren.svg',
                                                      colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      '사진 신고',
                                                      style: f12Gray800w600,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),

                              /// 하단 딤
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
                                        Colors.black.withOpacity(0.1),
                                        Colors.black.withOpacity(0.2),
                                        Colors.black.withOpacity(0.3),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 0,
                                right: 0, // 화면의 왼쪽과 오른쪽에 닿도록 설정
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          notis.notificationHistory['profileImage'] == ''
                                              ? Container(width: 24, height: 24, child: DefaultProfileScreen(context))
                                              : CachedNetworkImage(
                                                  imageUrl: notis.notificationHistory['profileImage'],
                                                  width: 24,
                                                  height: 24,
                                                  fit: BoxFit.cover,
                                                  errorWidget: (context, url, error) => DefaultProfileScreen(context),
                                                ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '${notis.notificationHistory['nickname']}',
                                            style: f12whitew600,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            '${notis.notificationHistory['photoDate']}',
                                            style: f12whitew600,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const SizedBox(),
                                      notis.notificationHistory['memo'] == ''
                                          ? const SizedBox()
                                          : Wrap(
                                              children: [
                                                Text(
                                                  '${notis.notificationHistory['memo']}',
                                                  style: f15whitew500,
                                                  maxLines: 10, // 최대 줄 수 설정
                                                  overflow: TextOverflow.ellipsis, // 텍스트가 오버플로우될 경우 처리
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          notis.notificationHistory['tags'][0] == null
                              ? Container(
                                  width: Get.width,
                                  height: 52,
                                  color: gray50,
                                )
                              : Container(
                                  width: Get.width,
                                  color: gray50,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      alignment: WrapAlignment.start,
                                      spacing: 12,
                                      children: notis.notificationHistory['tags'].map<Widget>((tag) {
                                        return Container(
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
                                                    color: Color(int.parse('0xff${tag['tagColor']}')), // 태그 색깔
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: Text('#',
                                                        style: tag['tagColor'] == 'FFFFFFFF'
                                                            ? f12gray900w500
                                                            : f12whitew500),
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                Text('${tag['tagName']}', style: f12gray900w500), // 태그 이름
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          await notis.notificationToggle(widget.tripId, widget.historyId);
                                        },
                                        child: SvgPicture.asset('assets/icon/heart.svg',
                                            colorFilter: ColorFilter.mode(
                                                notis.notificationHistory['like'] ?? false ? gray900 : gray300,
                                                BlendMode.srcIn))),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${notis.notificationHistory['likeCnt']}',
                                      style: f14Gray800w500,
                                    ),
                                    const SizedBox(width: 8),
                                    SvgPicture.asset('assets/icon/chat.svg',
                                        colorFilter: ColorFilter.mode(gray900, BlendMode.srcIn)),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${notis.notificationHistory['replyCnt']}',
                                      style: f14Gray800w500,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Obx(() => ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: notis.notificationComment.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(4),
                                                  child: CachedNetworkImage(
                                                    imageUrl: '${notis.notificationComment[index]['profileImage']}',
                                                    width: 24,
                                                    height: 24,
                                                    fit: BoxFit.fill,
                                                    errorWidget: (context, url, error) => DefaultProfileScreen(context),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text('${notis.notificationComment[index]['nickname']}',
                                                    style: f12Gray800w600),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  '${hs.timeFormat(notis.notificationComment[index]['createDate'])}',
                                                  style: f11gray400w500,
                                                ),
                                                Spacer(),
                                                us.userList[0].uuid == notis.notificationComment[index]['writerUuid']
                                                    ? PopupMenuButton(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        offset: const Offset(-20, 40),
                                                        shadowColor: Colors.black.withOpacity(0.4),
                                                        icon: Container(
                                                          height: 24,
                                                          width: 24,
                                                          alignment: Alignment.centerRight,
                                                          child: SvgPicture.asset(
                                                            'assets/icon/dot.svg',
                                                          ),
                                                        ),
                                                        color: gray50,
                                                        itemBuilder: (context) => [
                                                              PopupMenuItem(
                                                                padding: EdgeInsets.zero,
                                                                value: 1,
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.symmetric(
                                                                          horizontal: 12, vertical: 8),
                                                                      child: Container(
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            Center(
                                                                                child: SvgPicture.asset(
                                                                                    'assets/icon/pencil.svg',
                                                                                    colorFilter: ColorFilter.mode(
                                                                                        gray600, BlendMode.srcIn))),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Text(
                                                                              '댓글 수정',
                                                                              style: f12Gray800w600,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const Divider(
                                                                      color: gray200,
                                                                    ), // Divider를 Column 내의 다른 자식으로 이동
                                                                  ],
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    editingIdx = index;
                                                                    isEditing = true;
                                                                  });
                                                                  FocusScope.of(context).requestFocus(_focusNode);
                                                                  textCon.text =
                                                                      notis.notificationComment[index]['content'];
                                                                },
                                                              ),
                                                              PopupMenuItem(
                                                                onTap: () {
                                                                  FocusScope.of(context).unfocus();
                                                                  notis.deleteNotificationComment(
                                                                      widget.tripId,
                                                                      widget.historyId,
                                                                      notis.notificationComment[index]['id']);
                                                                },
                                                                height: 0,
                                                                padding: EdgeInsets.zero,
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.symmetric(
                                                                          horizontal: 12, vertical: 8),
                                                                      child: Container(
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            Center(
                                                                                child: SvgPicture.asset(
                                                                                    'assets/icon/normalTrashCan.svg',
                                                                                    colorFilter: ColorFilter.mode(
                                                                                        gray600, BlendMode.srcIn))),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Text(
                                                                              '댓글 삭제',
                                                                              style: f12Gray800w600,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ])
                                                    : PopupMenuButton(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        offset: const Offset(-20, 40),
                                                        shadowColor: Colors.black.withOpacity(0.4),
                                                        splashRadius: 10,
                                                        icon: Container(
                                                          height: 24,
                                                          width: 24,
                                                          alignment: Alignment.centerRight,
                                                          child: SvgPicture.asset(
                                                            'assets/icon/dot.svg',
                                                          ),
                                                        ),
                                                        color: gray50,
                                                        itemBuilder: (context) => [
                                                              PopupMenuItem(
                                                                onTap: () async {
                                                                  await rs.addReport(
                                                                      'reply',
                                                                      notis.notificationComment[index]['id'],
                                                                      notis.notificationComment[index]['id']);
                                                                },
                                                                padding: EdgeInsets.zero,
                                                                value: 1,
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.symmetric(
                                                                          horizontal: 12, vertical: 8),
                                                                      child: Container(
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            Center(
                                                                                child: SvgPicture.asset(
                                                                                    'assets/icon/siren.svg',
                                                                                    colorFilter: ColorFilter.mode(
                                                                                        gray600, BlendMode.srcIn))),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Text(
                                                                              '댓글 신고',
                                                                              style: f12Gray800w600,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ]),
                                              ],
                                            ),
                                            // const SizedBox(height: 4),
                                            Text('${notis.notificationComment[index]['content']}',
                                                style: f14gray800w600),
                                            const SizedBox(height: 16),
                                          ],
                                        );
                                      },
                                    )),
                                SizedBox(height: 80),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            )),
        bottomSheet: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: gray50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: gray200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormFieldComponent(
                      controller: textCon,
                      hintText: '댓글을 입력해주세요',
                      onFieldSubmitted: (v) async {
                        if (textCon.text.trim().isNotEmpty) {
                          if (isEditing) {
                            notis.editNotificationComment(widget.tripId, widget.historyId,
                                notis.notificationComment[editingIdx!]['id'], textCon.text);
                            textCon.text = '';
                            isEditing = false;
                            FocusScope.of(context).unfocus();
                          } else {
                            notis.addNotificationComment(widget.tripId, widget.historyId, textCon.text, false);
                            textCon.text = '';
                            FocusScope.of(context).unfocus();
                            _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 100);
                          }
                        }
                        setState(() {});
                      },
                      focusNode: _focusNode,
                    )),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () async {
                        if (textCon.text.trim().isNotEmpty) {
                          if (isEditing) {
                            notis.editNotificationComment(widget.tripId, widget.historyId,
                                notis.notificationComment[editingIdx!]['id'], textCon.text);
                            textCon.text = '';
                            isEditing = false;
                            FocusScope.of(context).unfocus();
                          } else {
                            notis.addNotificationComment(widget.tripId, widget.historyId, textCon.text, false);
                            textCon.text = '';
                            FocusScope.of(context).unfocus();
                            _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 100);
                          }
                        }
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(color: gray900, borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(
                            '${isEditing ? '수정' : '등록'}',
                            style: f12Whitew700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
