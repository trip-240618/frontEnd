import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:tripStory/app/api/userApi.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/app/notification/firebase_cloud_messaging.dart';
import 'package:tripStory/component/bottomModals.dart';
import 'package:tripStory/component/button/popup_list.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/dialog/loading.dart';
import 'package:tripStory/component/dialog/snack_bar.dart';
import 'package:tripStory/component/empty/emptyScreen.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/controller/notificationState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/main/notification/notification_main.dart';
import 'package:tripStory/view/main/tripAdd/tripRoomAdd.dart';
import 'package:tripStory/view/myPage/myPage.dart';
import 'package:tripStory/view/trip/bottomNavigator.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainState ms = Get.put(MainState());
  NotiState notis = Get.put(NotiState());
  TripState ts = Get.put(TripState());
  JPlanState js = Get.put(JPlanState());
  final dioClient = DioClient();
  final apiUserClient = ApiUserClient(DioClient());
  bool isLoading = true;
  DateTime? currentBackPressTime;

  void initState() {
    Future.delayed(Duration.zero,()async{
      isLoading = false;
      await notis.getNotificationCount();
      await ms.getComingTrip();
      if(!ms.firstInit.value){
        ms.firstInit.value = true;
        await FCM().setNotifications();
      }
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool,dynamic) {
        if(currentBackPressTime == null || DateTime.now().difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
              buildCustomSnackBar('"뒤로" 버튼을 한 번 더 누르시면 종료됩니다')
          );
        }else{
          exit(0);
        }
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
             padding: const EdgeInsets.only(right: 20),
             child: Row(
               children: [
                 Obx(()=>GestureDetector(
                     onTap: (){
                       Get.to(()=>NotificationMain())?.then((v)async{
                         await notis.getNotificationCount();
                       });
                     },
                     child: Container(
                       width: 28,
                       child: Stack(
                           children: [
                             SvgPicture.asset('assets/icon/alert.svg'),
                             notis.notificationCount.value==0?const SizedBox():Positioned(
                               right: 0,
                               child: Container(
                                 width: 6,
                                 height: 6,
                                 decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     color: redColor
                                 ),
                               ),
                             )
                           ]),
                     ))),
                 const SizedBox(width: 8,),
                 GestureDetector(
                     onTap: (){
                       Get.to(()=>MyPage());
                     },
                     child: SvgPicture.asset('assets/icon/person.svg')),
               ],
             ),
           )
         ],
       ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 44),
          child: Column(
            children: [
              Obx(()=> Row(
                children: [
                  GestureDetector(
                    onTap: ()async{
                      ms.selectIdx.value = 0;
                      setState(() {
                        isLoading = true;
                      });
                      await ms.getComingTrip();
                      setState(() {
                        isLoading = false;
                      });
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ms.selectIdx==0?gray900:gray200,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                        child: Text('다가오는 여행',style: ms.selectIdx==0?f14Whitew700:f14gray400w700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: ()async{
                      ms.selectIdx.value = 1;
                      setState(() {
                        isLoading = true;
                      });
                      await ms.getLastTrip();
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ms.selectIdx==1?gray900:gray200,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                        child: Text('지난 여행',style: ms.selectIdx==1?f14Whitew700:f14gray400w700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: ()async{
                      ms.selectIdx.value = 2;
                      setState(() {
                        isLoading = true;
                      });
                      await ms.getBookMarkTrip();
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ms.selectIdx==2?gray900:gray200,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                        child: Text('북마크',style: ms.selectIdx==2?f14Whitew700:f14gray400w700),
                      ),
                    ),
                  )
                ],
              )),
              const SizedBox(height: 32),
              isLoading?Expanded(child: LoadingWidget()):Obx(()=>Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: ms.tripList.length==0?1:ms.tripList.length,
                      itemBuilder: (contexts, index) {
                        return ms.tripList.length==0?EmptyScreen(context)
                            :Column(
                              children: [
                                GestureDetector(
                                  behavior:HitTestBehavior.opaque,
                                  onTap:()async{
                                    await ts.getSelectTrip(ms.tripList[index]['id']);
                                    Get.to(()=>BottomNavigator())?.then((v)async{
                                      await notis.getNotificationCount();
                                    });
                                  },
                                  child: Container(
                                    width: Get.width,
                                    height: 140,
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(4)
                                    ),
                                    child: Stack(
                                      children: [
                                        SvgPicture.asset('assets/icon/ticket.svg',
                                            width: Get.width,
                                            height:Get.height,
                                            fit: BoxFit.fill),
                                        Positioned(
                                            left: 16,
                                            top: 8,
                                            right: 16,
                                            child: Container(
                                              width: Get.width,
                                              child: Row(
                                                children: [
                                                  ms.selectIdx.value==1?SvgPicture.asset('assets/icon/calender.svg',colorFilter: ColorFilter.mode(gray600,BlendMode.srcIn)):Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Color(int.parse('${ms.tripList[index]['labelColor']}')),
                                                          width: 1.5, // 1.5px 두께
                                                        ),
                                                        borderRadius: BorderRadius.circular(100)
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical:2,horizontal: 10),
                                                      child: Text((DateTime.parse('${ms.tripList[index]['startDate']}').difference(DateTime.now()).inDays + 1)<1?'여행중':'D-${DateTime.parse('${ms.tripList[index]['startDate']}').difference(DateTime.now()).inDays + 1}',style: changeColor(Color(int.parse('${ms.tripList[index]['labelColor']}'))),),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text('${ms.tripList[index]['startDate']} ~ ${ms.tripList[index]['endDate']}',style: f12Gray800w500,),
                                                  Spacer(),
                                                  ms.selectIdx.value==1
                                                      ?const SizedBox()
                                                      :GestureDetector(
                                                        behavior:HitTestBehavior.opaque,
                                                        onTap: (){
                                                            sendBottomModal(context,ms.tripList[index]['invitationCode'],ms.tripList[index]['id']);
                                                        },
                                                          child: Container(
                                                              padding: const EdgeInsets.all(6.0),
                                                              child: SvgPicture.asset('assets/icon/send.svg',color: gray900))
                                                  ),
                                                  const SizedBox(width: 4),
                                                  InkWell(
                                                    onTap: ()async{
                                                      await ms.bookmarkClick(int.parse('${ms.tripList[index]['id']}'));
                                                      ms.tripList[index]['bookmark'] = !ms.tripList[index]['bookmark'];
                                                      ms.tripList.refresh();
                                                    },
                                                    highlightColor: Colors.black,
                                                    splashColor: Colors.black,
                                                    child: Container(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: ms.tripList[index]['bookmark']
                                                          ? SvgPicture.asset(
                                                        'assets/icon/checkBookmark.svg',
                                                        fit: BoxFit.none,
                                                      )
                                                          : SvgPicture.asset(
                                                        'assets/icon/bookmark.svg',
                                                        fit: BoxFit.none,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                        ),
                                        Positioned(
                                            left: 16,
                                            top: 58,
                                            right: 16,
                                            bottom: 14,
                                            child: Container(
                                              width: Get.width,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:66,
                                                    height: 66,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(4),
                                                      child: ms.tripList[index]['thumbnail']==''?DefaultImageScreen(context):CachedNetworkImage(
                                                        imageUrl:'${ms.tripList[index]['thumbnail']}',
                                                        imageBuilder: (context, imageProvider) => Container(
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: imageProvider,
                                                                fit: BoxFit.fill
                                                            ),
                                                          ),
                                                        ),
                                                        errorWidget: (context, url, error) {
                                                          return DefaultImageScreen(context);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                  color: Color(int.parse('${ms.tripList[index]['labelColor']}')),
                                                                  shape: BoxShape.circle
                                                              ),
                                                              child: Center(child: Text('${ms.tripList[index]['type']}',style: f12Whitew700,))
                                                          ),
                                                          const SizedBox(width: 6),
                                                          Text('${ms.tripList[index]['name']}',style: f15gray800w600,)
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Text('${ms.tripList[index]['country']}',style: f12gray600w600,),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Builder(
                                                      builder: (context) {
                                                        return Column(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            GestureDetector(
                                                              onTap:()async{
                                                                int maxlen = await getLongestNicknameLength(ms.tripList[index]['tripMemberDtoList']);
                                                                showPopover(
                                                                    context: context,
                                                                    bodyBuilder: (context) => ListItems(index: index,),
                                                                    direction: PopoverDirection.bottom,
                                                                    width: 14*maxlen+100,
                                                                    height: 50*ms.tripList[index]['tripMemberDtoList'].length+0,
                                                                    contentDyOffset: 10,
                                                                    arrowHeight: 8,
                                                                    arrowWidth: 13
                                                                );
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: gray200,
                                                                    borderRadius: BorderRadius.circular(100)
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture.asset(
                                                                        'assets/icon/userIcon.svg',
                                                                      ),
                                                                      const SizedBox(width: 5),
                                                                      Text('${ms.tripList[index]['tripMemberDtoList'].length}',style: f14gray600w700,)
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                  )
                                                ],
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12)
                              ],
                        );
                      }),
                ),
              )),
              const SizedBox(height: 10,),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      InviteDialog(context,() {
                        Get.back();
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: gray700,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: SvgPicture.asset('assets/icon/chain.svg'
                        ,fit: BoxFit.none,
                         colorFilter: ColorFilter.mode(Colors.white,BlendMode.srcIn)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.to(()=>TripRoomAddScreen());
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: gray900,
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Center(child: Text('새 여행방 생성',style: f16Whitew700,)),
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
  }
}

Future<int> getLongestNicknameLength(List<dynamic> tripMemberDtoList) async{
  int longestLength = 0;

  for (var member in tripMemberDtoList) {
    String nickname = member['nickname'] ?? ''; // null 값 방지를 위해 기본값 '' 처리
    if (nickname.length > longestLength) {
      longestLength = nickname.length;
    }
  }
  return longestLength;
}



