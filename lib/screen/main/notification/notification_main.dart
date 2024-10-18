import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/controller/userState.dart';
import '../../../component/appbar.dart';
import '../../../controller/notificationState.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';
import 'package:intl/intl.dart';
import '../../trip/bottomNavigator.dart';

class NotificationMain extends StatefulWidget {
  const NotificationMain({super.key});

  @override
  State<NotificationMain> createState() => _NotificationMainState();
}

class _NotificationMainState extends State<NotificationMain> {
  NotiState notis = Get.put(NotiState());
  DateTime now = DateTime.now();
  final ts = Get.put(TripState());
  final us = Get.put(UserState());
  @override
  void initState() {
    notis.getNotificationList('여행 일정');
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
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
                  onTap: (){
                    notis.selectTabIndex.value = 0;
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
                  onTap: (){
                    notis.selectTabIndex.value = 1;
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
                  onTap: (){
                    notis.selectTabIndex.value = 2;
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
            Obx(()=>notis.notificationList.isEmpty?const SizedBox():Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: notis.notificationList.length,
                    itemBuilder: (contexts, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: ()async{
                              // await ts.getSelectTrip(notis.notificationList[index]['tripId']);
                              // Get.back();
                              Get.off(()=>BottomNavigator(notificationIdx: 2,));
                            },
                            child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color:Colors.white,
                                    borderRadius:BorderRadius.circular(4),
                                    border: Border.all(color: gray200)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: yellowColor,
                                            shape: BoxShape.circle
                                        ),
                                        child: SvgPicture.asset('assets/icon/smallalert.svg',fit: BoxFit.none,),
                                      ),
                                      const SizedBox(width: 8,),
                                      Expanded(  // 이 부분 추가
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 2),
                                            Text('${notis.notificationList[index]['title']}', style: f12Gray800w700),
                                            const SizedBox(height: 2),
                                            Text(
                                              '${notis.notificationList[index]['content']}',
                                              style: f14Gray800w500,
                                              maxLines: 2,  // 최대 2줄
                                              overflow: TextOverflow.ellipsis,  // 넘치면 ellipsis로 처리
                                            ),
                                            const SizedBox(height: 4,),
                                            Text('${timeAgo(DateTime.parse('${notis.notificationList[index]['createDate']}'))}',style: f11gray400w500,)
                                          ],
                                        ),
                                      ),
                                      notis.notificationList[index]['read']?const SizedBox():Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ),
                          ),
                          SizedBox(height: 12)
                        ],
                      );
                    }),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
