import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:tripStory/app/data/models/trip_room_model.dart';
import 'package:tripStory/common/button/popup_list.dart';
import 'package:tripStory/common/button/round_button.dart';
import 'package:tripStory/common/snack_bar.dart';
import 'package:tripStory/component/bottomModals.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/empty/emptyScreen.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/main/main_page/controller/rooms_controller.dart';
import 'package:tripStory/view/main/tripAdd/tripRoomAdd.dart';

class TripRoomListView extends StatelessWidget {
  const TripRoomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomsController>(
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (value, dynamic) {
            // TODO: 안드로이드 실기기에서 테스트 진행해야 함
            if (controller.shouldExitOnBackPressed()) {
              exit(0);
            }

            SnackBarHelper.show(
              context,
              '"뒤로" 버튼을 한 번 더 누르시면 종료됩니다',
            );
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: gray50,
            appBar: AppBar(
              backgroundColor: gray50,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              toolbarHeight: 44,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => controller.onNotificationPressed(),
                        child: SizedBox(
                          width: 28,
                          child: Stack(
                            children: [
                              SvgPicture.asset('assets/icon/alert.svg'),
                              controller.notificationCount == 0
                                  ? const SizedBox()
                                  : Positioned(
                                      right: 0,
                                      child: Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: redColor,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () => controller.onMyPagePressed(),
                        child: SvgPicture.asset('assets/icon/person.svg'),
                      ),
                    ],
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 44,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      RoundedBoxButton(
                        backgroundColor: controller.selectIdx == 0 ? gray900 : gray200,
                        onTap: () => controller.getComingTrip(),
                        child: Text(
                          "다가오는 여행",
                          style: controller.selectIdx == 0 ? f14Whitew700 : f14gray400w700,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      RoundedBoxButton(
                        backgroundColor: controller.selectIdx == 1 ? gray900 : gray200,
                        onTap: () => controller.getLastTrip(),
                        child: Text(
                          "지난 여행",
                          style: controller.selectIdx == 1 ? f14Whitew700 : f14gray400w700,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      RoundedBoxButton(
                        backgroundColor: controller.selectIdx == 2 ? gray900 : gray200,
                        onTap: () => controller.getBookMarkTrip(),
                        child: Text(
                          "북마크",
                          style: controller.selectIdx == 2 ? f14Whitew700 : f14gray400w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: controller.tripRooms.isEmpty
                        ? EmptyScreen(context)
                        : SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: controller.tripListLength(),
                                itemBuilder: (contexts, index) {
                                  final tripRoom = controller.tripRooms[index];
                                  return Column(
                                    children: [
                                      _TripRoomTile(
                                        data: tripRoom,
                                        selectedIndex: controller.selectIdx,
                                        onTap: () => controller.onRoomPressed(),
                                        onBookmarkTap: () => controller.bookmarkClick(tripRoom.id),
                                        onSendTap: () {
                                          sendBottomModal(
                                            context,
                                            tripRoom.invitationCode,
                                            tripRoom.id,
                                          );
                                        },
                                        onMemberTap: (contexts) => showPopover(
                                          context: contexts,
                                          bodyBuilder: (context) => Material(
                                            child: PopupList(
                                              members: controller.getPopupMembers(tripRoom),
                                            ),
                                          ),
                                          direction: PopoverDirection.bottom,
                                          width: 14 * controller.tripRooms[index].longestNicknameLength + 100,
                                          height: 50 * tripRoom.memberLength.toDouble(),
                                          contentDyOffset: 10,
                                          arrowHeight: 8,
                                          arrowWidth: 13,
                                        ),
                                      ),
                                      // GestureDetector(
                                      //   behavior: HitTestBehavior.opaque,
                                      //   onTap: () async {
                                      //     // await ts.getSelectTrip(ms.tripList[index]['id']);
                                      //     // Get.to(() => BottomNavigator())?.then((v) async {
                                      //     //   await notis.getNotificationCount();
                                      //     // });
                                      //   },
                                      //   child: Container(
                                      //     width: Get.width,
                                      //     height: 140,
                                      //     decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.circular(4),
                                      //     ),
                                      //     child: Stack(
                                      //       children: [
                                      //         SvgPicture.asset('assets/icon/ticket.svg',
                                      //             width: Get.width, height: Get.height, fit: BoxFit.fill),
                                      //         Positioned(
                                      //             left: 16,
                                      //             top: 8,
                                      //             right: 16,
                                      //             child: Container(
                                      //               width: Get.width,
                                      //               child: Row(
                                      //                 children: [
                                      //                   controller.selectIdx == 1
                                      //                       ? SvgPicture.asset('assets/icon/calender.svg',
                                      //                           colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn))
                                      //                       : Container(
                                      //                           decoration: BoxDecoration(
                                      //                               border: Border.all(
                                      //                                 color: Color(int.parse(
                                      //                                     '${controller.tripList[index].labelColor}')),
                                      //                                 width: 1.5, // 1.5px 두께
                                      //                               ),
                                      //                               borderRadius: BorderRadius.circular(100)),
                                      //                           child: Padding(
                                      //                             padding: const EdgeInsets.symmetric(
                                      //                                 vertical: 2, horizontal: 10),
                                      //                             child: Text(
                                      //                               (DateTime.parse('${controller.tripList[index].startDate}')
                                      //                                               .difference(DateTime.now())
                                      //                                               .inDays +
                                      //                                           1) <
                                      //                                       1
                                      //                                   ? '여행중'
                                      //                                   : 'D-${DateTime.parse('${controller.tripList[index].startDate}').difference(DateTime.now()).inDays + 1}',
                                      //                               style: changeColor(Color(int.parse(
                                      //                                   '${controller.tripList[index].labelColor}'))),
                                      //                             ),
                                      //                           ),
                                      //                         ),
                                      //                   const SizedBox(width: 6),
                                      //                   Text(
                                      //                     '${controller.tripList[index].startDate} ~ ${controller.tripList[index].endDate}',
                                      //                     style: f12Gray800w500,
                                      //                   ),
                                      //                   Spacer(),
                                      //                   controller.selectIdx == 1
                                      //                       ? const SizedBox()
                                      //                       : GestureDetector(
                                      //                           behavior: HitTestBehavior.opaque,
                                      //                           onTap: () {
                                      //                             // sendBottomModal(
                                      //                             //     context,
                                      //                             //     ms.tripList[index]['invitationCode'],
                                      //                             //     ms.tripList[index]['id']);
                                      //                           },
                                      //                           child: Container(
                                      //                               padding: const EdgeInsets.all(6.0),
                                      //                               child: SvgPicture.asset('assets/icon/send.svg',
                                      //                                   color: gray900))),
                                      //                   const SizedBox(width: 4),
                                      //                   InkWell(
                                      //                     onTap: () async {
                                      //                       await controller.bookmarkClick(
                                      //                           int.parse('${controller.tripList[index].id}'));
                                      //                       // controller.tripList[index]['bookmark'] = !controller.tripList[index]['bookmark'];
                                      //                       // controller.tripList.refresh();
                                      //                     },
                                      //                     highlightColor: Colors.black,
                                      //                     splashColor: Colors.black,
                                      //                     child: Container(
                                      //                       padding: const EdgeInsets.all(4.0),
                                      //                       child: controller.tripList[index].bookmark
                                      //                           ? SvgPicture.asset(
                                      //                               'assets/icon/checkBookmark.svg',
                                      //                               fit: BoxFit.none,
                                      //                             )
                                      //                           : SvgPicture.asset(
                                      //                               'assets/icon/bookmark.svg',
                                      //                               fit: BoxFit.none,
                                      //                             ),
                                      //                     ),
                                      //                   )
                                      //                 ],
                                      //               ),
                                      //             )),
                                      //         Positioned(
                                      //           left: 16,
                                      //           top: 58,
                                      //           right: 16,
                                      //           bottom: 14,
                                      //           child: SizedBox(
                                      //             width: Get.width,
                                      //             child: Row(
                                      //               mainAxisAlignment: MainAxisAlignment.start,
                                      //               crossAxisAlignment: CrossAxisAlignment.start,
                                      //               children: [
                                      //                 SizedBox(
                                      //                   width: 66,
                                      //                   height: 66,
                                      //                   child: ClipRRect(
                                      //                     borderRadius: BorderRadius.circular(4),
                                      //                     child: CachedNetworkImage(
                                      //                       imageUrl: controller.tripList[index].thumbnail ?? "",
                                      //                       imageBuilder: (context, imageProvider) => Container(
                                      //                         decoration: BoxDecoration(
                                      //                           image: DecorationImage(
                                      //                               image: imageProvider, fit: BoxFit.fill),
                                      //                         ),
                                      //                       ),
                                      //                       errorWidget: (context, url, error) {
                                      //                         return DefaultImageScreen(context);
                                      //                       },
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //                 const SizedBox(width: 12),
                                      //                 Column(
                                      //                   mainAxisAlignment: MainAxisAlignment.start,
                                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                                      //                   children: [
                                      //                     Row(
                                      //                       children: [
                                      //                         Container(
                                      //                           width: 20,
                                      //                           height: 20,
                                      //                           decoration: BoxDecoration(
                                      //                               color: Color(
                                      //                                 int.parse(controller.tripList[index].labelColor),
                                      //                               ),
                                      //                               shape: BoxShape.circle),
                                      //                           child: Center(
                                      //                             child: Text(
                                      //                               controller.tripList[index].type,
                                      //                               style: f12Whitew700,
                                      //                             ),
                                      //                           ),
                                      //                         ),
                                      //                         const SizedBox(width: 6),
                                      //                         Text(
                                      //                           controller.tripList[index].name,
                                      //                           style: f15gray800w600,
                                      //                         )
                                      //                       ],
                                      //                     ),
                                      //                     Spacer(),
                                      //                     Text(
                                      //                       controller.tripList[index].country,
                                      //                       style: f12gray600w600,
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //                 Spacer(),
                                      //                 Builder(builder: (context) {
                                      //                   return Column(
                                      //                     mainAxisAlignment: MainAxisAlignment.end,
                                      //                     children: [
                                      //                       GestureDetector(
                                      //                         onTap: () async {
                                      //                           int maxlen = await getLongestNicknameLength(
                                      //                               ms.tripList[index]['tripMemberDtoList']);
                                      //                           showPopover(
                                      //                               context: context,
                                      //                               bodyBuilder: (context) => ListItems(
                                      //                                     index: index,
                                      //                                   ),
                                      //                               direction: PopoverDirection.bottom,
                                      //                               width: 14 * maxlen + 100,
                                      //                               height: 50 *
                                      //                                       ms.tripList[index]['tripMemberDtoList']
                                      //                                           .length +
                                      //                                   0,
                                      //                               contentDyOffset: 10,
                                      //                               arrowHeight: 8,
                                      //                               arrowWidth: 13);
                                      //                         },
                                      //                         child: Container(
                                      //                           decoration: BoxDecoration(
                                      //                               color: gray200,
                                      //                               borderRadius: BorderRadius.circular(100)),
                                      //                           child: Padding(
                                      //                             padding: const EdgeInsets.symmetric(
                                      //                                 horizontal: 12, vertical: 5),
                                      //                             child: Row(
                                      //                               children: [
                                      //                                 SvgPicture.asset(
                                      //                                   'assets/icon/userIcon.svg',
                                      //                                 ),
                                      //                                 const SizedBox(width: 5),
                                      //                                 Text(
                                      //                                   '${controller.tripList[index].tripMemberDtoList.length}',
                                      //                                   style: f14gray600w700,
                                      //                                 )
                                      //                               ],
                                      //                             ),
                                      //                           ),
                                      //                         ),
                                      //                       ),
                                      //                     ],
                                      //                   );
                                      //                 })
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(height: 12)
                                    ],
                                  );
                                }),
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          InviteDialog(context, () {
                            Get.back();
                          });
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(color: gray700, borderRadius: BorderRadius.circular(4)),
                          child: SvgPicture.asset('assets/icon/chain.svg',
                              fit: BoxFit.none, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => TripRoomAddScreen());
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: gray900,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                '새 여행방 생성',
                                style: f16Whitew700,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TripRoomTile extends StatelessWidget {
  final TripRoomModel data;
  final int selectedIndex;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onSendTap;
  final Function(BuildContext)? onMemberTap;

  const _TripRoomTile({
    required this.data,
    required this.selectedIndex,
    this.onTap,
    this.onBookmarkTap,
    this.onSendTap,
    this.onMemberTap,
  });

  @override
  Widget build(BuildContext context) {
    final labelColor = Color(int.tryParse(data.labelColor) ?? 0xFF000000);
    final dDay = DateTime.parse(data.startDate).difference(DateTime.now()).inDays + 1;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/icon/ticket.svg',
              width: Get.width,
              height: Get.height,
              fit: BoxFit.fill,
            ),
            Positioned(
              left: 16,
              top: 8,
              right: 16,
              child: Row(
                children: [
                  selectedIndex == 1
                      ? SvgPicture.asset('assets/icon/calender.svg',
                          colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn))
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: labelColor, width: 1.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          child: Text(
                            dDay < 1 ? '여행중' : 'D-$dDay',
                            style: changeColor(labelColor),
                          ),
                        ),
                  const SizedBox(width: 6),
                  Text('${data.startDate} ~ ${data.endDate}', style: f12Gray800w500),
                  const Spacer(),
                  if (selectedIndex != 1)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onSendTap,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset('assets/icon/send.svg', color: gray900),
                      ),
                    ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: onBookmarkTap,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: data.bookmark
                          ? SvgPicture.asset('assets/icon/checkBookmark.svg')
                          : SvgPicture.asset('assets/icon/bookmark.svg'),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 16,
              top: 58,
              right: 16,
              bottom: 14,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: data.thumbnail ?? '',
                      imageBuilder: (context, imageProvider) => Container(
                        width: 66,
                        height: 66,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      errorWidget: (context, url, error) => DefaultImageScreen(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(color: labelColor, shape: BoxShape.circle),
                            child: Center(
                              child: Text(data.type, style: f12Whitew700),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(data.name, style: f15gray800w600),
                        ],
                      ),
                      const Spacer(),
                      Text(data.country, style: f12gray600w600),
                    ],
                  ),
                  const Spacer(),
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () => onMemberTap?.call(context),
                      child: Container(
                        decoration: BoxDecoration(color: gray200, borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icon/userIcon.svg'),
                            const SizedBox(width: 5),
                            Text('${data.tripMemberDtoList.length}', style: f14gray600w700),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
