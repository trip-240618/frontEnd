import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/empty/emptyScreen.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/main/main_page/views/trip_room_list_view.dart';


class MemberList extends StatefulWidget {
  const MemberList({super.key});

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  final ts = Get.put(TripState());
  final us = Get.put(UserState());
  final ms = Get.put(MainState());
  bool leaderCheck = false;
  List memberList = [];
  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      for (int i = 0; i < ts.selectTripList[0]['tripMemberDtoList'].length; i++) {
        var tripMember = ts.selectTripList[0]['tripMemberDtoList'][i];
        if (tripMember['uuid'] == us.userList[0].uuid) {
          if (tripMember['leader']) {
            leaderCheck = true;
          }
          memberList.insert(0, tripMember);
        } else {
          memberList.add(tripMember);
        }
      }
      setState(() {});
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      appBar: BackAppBar(text: '여행방 멤버', onTap: () {
        Get.back();
      },color: gray50,),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 28),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: gray200)
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: memberList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: memberList.length - 1==index?BorderSide.none:BorderSide( // 아래쪽(border bottom)만 색상 적용
                          color: gray200, // 원하는 색상
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                      child: Row(
                        children: [
                          memberList[index]['leader']?Container(
                            width:30,
                            height:30,
                            child: Stack(
                              children: [
                                Container(
                                  width:25,
                                  height:25,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: CachedNetworkImage(
                                      imageUrl:'${memberList[index]['thumbnail']}',
                                      imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover
                                          ),
                                        ),
                                      ),
                                      // placeholder: (context, url) => const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => DefaultProfileScreen(context),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: SvgPicture.asset('assets/icon/owner.svg'))
                              ],
                            ),
                          ): Container(
                            width:30,
                            child: Row(
                              children: [
                                Container(
                                  width:24,
                                  height: 24,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: CachedNetworkImage(
                                      imageUrl:'${memberList[index]['thumbnail']}',
                                      imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill
                                          ),
                                        ),
                                      ),
                                      // placeholder: (context, url) => const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => DefaultProfileScreen(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16,),
                          us.userList[0].uuid==memberList[index]['uuid']?Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    color: gray900,
                                    shape: BoxShape.circle
                                ),
                                child: Center(child: Text('나',style: f10Whitew700,)),
                              ),
                              const SizedBox(width: 4,),
                            ],
                          ):const SizedBox(),
                          Text('${memberList[index]['nickname']}',style: f15gray800w500,),
                          Spacer(),
                          !leaderCheck && us.userList[0].uuid!=memberList[index]['uuid'] ?const SizedBox():
                          us.userList[0].uuid==memberList[index]['uuid']
                              ? GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: ()async{
                                    showConfirmCancelTapDialog(context, '여행방을 나가시겠습니까?','확인',null, ()async{
                                      await ts.leaveTrip(ts.selectTripList[0]['id'], ts.selectTripList[0]['type']);
                                      ms.selectIdx.value = 0;
                                      ms.selectIdx.refresh();
                                      Get.offAll(()=>TripRoomListView());
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: redColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                                      child: Text('여행방 나가기',style: f12Whitew700,),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                onTap: (){
                                  ts.kickTrip(ts.selectTripList[0]['id'], 'j', memberList[index]['uuid']);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: gray900,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                                      child: Text('내보내기',style: f12Whitew700,),
                                    ),
                                 ),
                              )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
