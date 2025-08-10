import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/tab/tab_box.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/view/hoom/controller/notification_list_controller.dart';
import 'package:tripStory/view/hoom/enum/notification_type.dart';

class NotificationListView extends StatelessWidget {
  const NotificationListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationListController>(builder: (controller) {
      return Scaffold(
        backgroundColor: gray50,
        appBar: AppAppbar(
          text: "알림",
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 17),
          child: Column(
            children: [
              Row(
                children: [
                  TabBox(
                    label: "전체",
                    onPressed: () => controller.onAllPressed(),
                    selected: controller.state.notificationType == NotificationType.all,
                  ),
                  const SizedBox(width: 8),
                  TabBox(
                    label: "여행 일정",
                    onPressed: () => controller.onTripSchedulePressed(),
                    selected: controller.state.notificationType == NotificationType.tripSchedule,
                  ),
                  const SizedBox(width: 8),
                  TabBox(
                    label: "여행 기록",
                    onPressed: () => controller.onTripLogPressed(),
                    selected: controller.state.notificationType == NotificationType.tripLog,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Expanded(
              //     child: PagedListView<int, Map<String, dynamic>>(
              //   pagingController: _pagingController,
              //   builderDelegate: PagedChildBuilderDelegate<Map<String, dynamic>>(
              //     itemBuilder: (context, item, index) {
              //       return Column(
              //         children: [
              //           Slidable(
              //             key: ValueKey(item['id']),
              //             endActionPane: ActionPane(
              //               motion: const ScrollMotion(),
              //               extentRatio: 0.3,
              //               children: [
              //                 CustomSlidableAction(
              //                   onPressed: (context) {
              //                     notis.deleteNotification(index, item['id']);
              //                     _pagingController.itemList!.removeAt(index);
              //                     setState(() {});
              //                   },
              //                   backgroundColor: Colors.red,
              //                   foregroundColor: Colors.white,
              //                   child: SvgPicture.asset(
              //                     'assets/icon/trashCan.svg',
              //                     fit: BoxFit.none,
              //                     colorFilter: ColorFilter.mode(gray900, BlendMode.srcIn),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             child: GestureDetector(
              //               onTap: () async {
              //                 /// 여행일정과 기록 디테일 처리 로직
              //                 if (item['title'] == '여행 일정') {
              //                   notis.readNotification(item['id']);
              //                   Uri uri = Uri.parse(item['destination']);
              //                   String? tripId = uri.queryParameters['tripId'];
              //                   await ts.getSelectTrip(int.parse(tripId!));
              //                   Get.off(() => BottomNavigator());
              //                   _pagingController.itemList![index]['read'] = true;
              //                   setState(() {});
              //                 } else {
              //                   notis.readNotification(item['id']);
              //                   Uri uri = Uri.parse(item['destination']);
              //                   String? tripId = uri.queryParameters['tripId'];
              //                   String? historyId = uri.queryParameters['historyId'];
              //                   await notis.getNotificationDetail(int.parse(tripId!), int.parse(historyId!));
              //                   Get.to(() => NotiHistoryDetail(
              //                         tripId: int.parse(tripId),
              //                         historyId: int.parse(historyId),
              //                       ));
              //                 }
              //               },
              //               child: Container(
              //                 width: Get.width,
              //                 decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   borderRadius: BorderRadius.circular(4),
              //                   border: Border.all(color: gray200),
              //                 ),
              //                 child: Padding(
              //                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.start,
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Container(
              //                         width: 20,
              //                         height: 20,
              //                         decoration: BoxDecoration(
              //                           color: Color(int.parse(item['labelColor'])),
              //                           shape: BoxShape.circle,
              //                         ),
              //                         child: SvgPicture.asset(
              //                           'assets/icon/smallalert.svg',
              //                           fit: BoxFit.none,
              //                         ),
              //                       ),
              //                       const SizedBox(width: 8),
              //                       Expanded(
              //                         child: Column(
              //                           mainAxisAlignment: MainAxisAlignment.start,
              //                           crossAxisAlignment: CrossAxisAlignment.start,
              //                           children: [
              //                             const SizedBox(height: 2),
              //                             Text(
              //                               '${item['title']}',
              //                               style: f12Gray800w700,
              //                             ),
              //                             const SizedBox(height: 2),
              //                             Text(
              //                               '${item['content']}',
              //                               style: f14Gray800w500,
              //                               maxLines: 2,
              //                               overflow: TextOverflow.ellipsis,
              //                             ),
              //                             const SizedBox(height: 4),
              //                             Text(
              //                               '${timeAgo(DateTime.parse('${item['createDate']}'))}',
              //                               style: f11gray400w500,
              //                             )
              //                           ],
              //                         ),
              //                       ),
              //                       item['read']
              //                           ? const SizedBox()
              //                           : Container(
              //                               width: 6,
              //                               height: 6,
              //                               decoration: BoxDecoration(
              //                                 shape: BoxShape.circle,
              //                                 color: Colors.black,
              //                               ),
              //                             ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           const SizedBox(height: 12),
              //         ],
              //       );
              //     },
              //     noItemsFoundIndicatorBuilder: (context) => const SizedBox(),
              //     firstPageProgressIndicatorBuilder: (context) => Center(child: CircularProgressIndicator()),
              //     newPageProgressIndicatorBuilder: (context) => Center(child: CircularProgressIndicator()),
              //   ),
              // ))
            ],
          ),
        ),
      );
    });
  }
}
