import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/controller/userState.dart';
import '../../../component/appbar.dart';
import '../../../controller/notificationState.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';
import 'package:intl/intl.dart';
import '../../trip/bottomNavigator.dart';
import '../../trip/tripHistory/notification/noti_history_detail.dart';

class NotificationMain extends StatefulWidget {
  const NotificationMain({super.key});

  @override
  State<NotificationMain> createState() => _NotificationMainState();
}

class _NotificationMainState extends State<NotificationMain> with SingleTickerProviderStateMixin {
  final PagingController<int, Map<String, dynamic>> _pagingController = PagingController(firstPageKey: 0);
  DateTime now = DateTime.now();
  NotiState notis = Get.find<NotiState>();
  final ts = Get.find<TripState>();
  final us = Get.find<UserState>();

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
       notis.readAllNotification();
    });
    _pagingController.addPageRequestListener((pageKey) async{
      /// 마지막 id
      final lastId = pageKey!=0
          ? notis.notificationList.last['id'] as int
          : 0;
      final newItems = await notis.getNotificationList(
          notis.selectTabIndex==0?'':notis.selectTabIndex==1?'여행 일정':'여행 기록',
          lastId);
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
      notis.notificationList.addAll(newItems);
      notis.notificationList.refresh();
    });
    super.initState();
  }

  @override
  void dispose() {
    notis.notificationList.clear();
    _pagingController.dispose();
    super.dispose();
  }

  /// 타임
  String timeAgo(DateTime createDate) {
    final now = DateTime.now();
    final difference = now.difference(createDate);
    if (difference.inDays > 7) {
      return DateFormat('yyyy-MM-dd').format(createDate);
    } else if (difference.inDays >= 1) {
      if (difference.inDays == 1) {
        return '어제';
      } else {
        return '${difference.inDays}일 전';
      }
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      appBar: BackAppBar(text: '알림',onTap: (){Get.back();},),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 17),
        child: Column(
          children: [
            Obx(()=> Row(
              children: [
                GestureDetector(
                  onTap: ()async{
                    notis.selectTabIndex.value = 0;
                    notis.notificationList.clear();
                    _pagingController.itemList?.clear();
                    _pagingController.refresh();
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: notis.selectTabIndex==0?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('전체',style: notis.selectTabIndex==0?f14Whitew700:f14gray400w700),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: ()async{
                    notis.selectTabIndex.value = 1;
                    notis.notificationList.clear();
                    _pagingController.itemList?.clear();
                    _pagingController.refresh();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: notis.selectTabIndex==1?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('여행 일정',style: notis.selectTabIndex==1?f14Whitew700:f14gray400w700),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: ()async{
                    notis.selectTabIndex.value = 2;
                    notis.notificationList.clear();
                    _pagingController.itemList?.clear();
                    _pagingController.refresh();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: notis.selectTabIndex==2?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('여행 기록',style: notis.selectTabIndex==2?f14Whitew700:f14gray400w700),
                    ),
                  ),
                )
              ],
            )),
            const SizedBox(height: 20,),
            Expanded(
                child: PagedListView<int, Map<String, dynamic>>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Map<String, dynamic>>(
                    itemBuilder: (context, item, index){
                      return Column(
                        children: [
                          Slidable(
                            key: ValueKey(item['id']),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.3,
                              children: [
                                CustomSlidableAction(
                                  onPressed: (context) {
                                    notis.deleteNotification(index, item['id']);
                                    _pagingController.itemList!.removeAt(index);
                                    setState(() {});
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  child: SvgPicture.asset(
                                    'assets/icon/trashCan.svg',
                                    fit: BoxFit.none,
                                    colorFilter: ColorFilter.mode(gray900, BlendMode.srcIn),
                                  ),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                /// 여행일정과 기록 디테일 처리 로직
                                if (item['title'] == '여행 일정') {
                                  notis.readNotification(item['id']);
                                  Uri uri = Uri.parse(item['destination']);
                                  String? tripId = uri.queryParameters['tripId'];
                                  await ts.getSelectTrip(int.parse(tripId!));
                                  Get.off(() => BottomNavigator());
                                  _pagingController.itemList![index]['read'] = true;
                                  setState(() {});
                                } else {
                                  notis.readNotification(item['id']);
                                  Uri uri = Uri.parse(item['destination']);
                                  String? tripId = uri.queryParameters['tripId'];
                                  String? historyId = uri.queryParameters['historyId'];
                                  await notis.getNotificationDetail(int.parse(tripId!), int.parse(historyId!));
                                  Get.to(() => NotiHistoryDetail(
                                    tripId: int.parse(tripId),
                                    historyId: int.parse(historyId),
                                  ));
                                }
                              },
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: gray200),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Color(int.parse(item['labelColor'])),
                                          shape: BoxShape.circle,
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/icon/smallalert.svg',
                                          fit: BoxFit.none,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 2),
                                            Text(
                                              '${item['title']}',
                                              style: f12Gray800w700,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '${item['content']}',
                                              style: f14Gray800w500,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${timeAgo(DateTime.parse('${item['createDate']}'))}',
                                              style: f11gray400w500,
                                            )
                                          ],
                                        ),
                                      ),
                                      item['read']
                                          ? const SizedBox()
                                          : Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context)=>const SizedBox(),
                    firstPageProgressIndicatorBuilder: (context) =>
                        Center(child: CircularProgressIndicator()),
                    newPageProgressIndicatorBuilder: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
