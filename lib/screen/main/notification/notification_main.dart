import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../component/appbar.dart';
import '../../../controller/notificationState.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';

class NotificationMain extends StatefulWidget {
  const NotificationMain({super.key});

  @override
  State<NotificationMain> createState() => _NotificationMainState();
}

class _NotificationMainState extends State<NotificationMain> {
  NotiState ns = Get.put(NotiState());
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
                    ns.selectTabIndex.value = 0;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ns.selectTabIndex==0?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('전체',style: ns.selectTabIndex==0?f14Whitew700:f14gray400w700),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: (){
                    ns.selectTabIndex.value = 1;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ns.selectTabIndex==1?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('여행 일정',style: ns.selectTabIndex==1?f14Whitew700:f14gray400w700),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: (){
                    ns.selectTabIndex.value = 2;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ns.selectTabIndex==2?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('여행 기록',style: ns.selectTabIndex==2?f14Whitew700:f14gray400w700),
                    ),
                  ),
                )
              ],
            )),
            const SizedBox(height: 20,),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (contexts, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: (){
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
                                            Text('여행 일정', style: f12Gray800w700),
                                            const SizedBox(height: 2),
                                            Text(
                                              '문재석님이 여행자님의 게시물에 댓글을 남겼습니다: “여기 또 갈래?”',
                                              style: f14Gray800w500,
                                              maxLines: 2,  // 최대 2줄
                                              overflow: TextOverflow.ellipsis,  // 넘치면 ellipsis로 처리
                                            ),
                                            const SizedBox(height: 4,),
                                            Text('2시간 전',style: f11gray400w500,)
                                          ],
                                        ),
                                      ),
                                      Container(
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
            )
          ],
        ),
      ),
    );
  }
}
