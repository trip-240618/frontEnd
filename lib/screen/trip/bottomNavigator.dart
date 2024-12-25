import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/controller/pPlanState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/screen/trip/locker/lockerTapPage.dart';
import 'package:tripStory/screen/trip/setting/member_list.dart';
import 'package:tripStory/screen/trip/tripHistory/tripHistoryMain.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/jSchedulePage.dart';
import 'package:tripStory/screen/trip/setting/trip_edit_page.dart';
import 'package:tripStory/screen/trip/tripPlan/typeP/pPlanPage.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> with TickerProviderStateMixin {
  List<Widget> _widgetOptions = [];
  late TabController _bottomTabController;
  int _currentIndex = 0;
  final ms = Get.put(MainState());
  final ts = Get.put(TripState());
  final us = Get.put(UserState());
  final js = Get.put(JPlanState());
  final ps = Get.put(PPlanState());
  @override
  void initState() {
    _widgetOptions = [ts.selectTripList[0]['type']=='J'? JSchedulePage():PPlanPage(), LockerTapPage(), TripHistoryMainPage()];
    _bottomTabController = TabController(length: 3, vsync: this,initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult:(bool,dynamic)async{
        switch (ms.selectIdx.value) {
          case 0:
            await ms.getComingTrip();
            break;
          case 1:
            await ms.getLastTrip();
            break;
          case 2:
            await ms.getBookMarkTrip();
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        appBar: _currentIndex==2?null:AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          toolbarHeight: _currentIndex == 0&&ts.selectTripList[0]['type']=='P'?96:80,
          title: Obx(()=>Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                        onTap: ()async{
                          switch (ms.selectIdx.value) {
                            case 0:
                              await ms.getComingTrip();
                              break;
                            case 1:
                              await ms.getLastTrip();
                              break;
                            case 2:
                              await ms.getBookMarkTrip();
                              break;
                            default:
                              break;
                          }
                          Get.back();
                        },
                        child: SvgPicture.asset('assets/icon/home.svg',
                          color: gray900,
                          width: 24,
                        height: 30,)),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              '${ts.selectTripList[0]['name']}',
                              style: f18Gray900w600,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ts.selectTripList[0]['tripMemberDtoList'].firstWhere((member) => member['uuid'] == us.userList[0].uuid)['leader']
                        ?PopupMenuButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        offset: const Offset(-10, 20),
                        shadowColor: Colors.black.withOpacity(0.4),
                        child: SvgPicture.asset(
                          'assets/icon/dot.svg',
                          width: 24,
                          color: gray900,
                        ),
                        color: gray50,
                        padding: EdgeInsets.zero,
                        menuPadding: EdgeInsets.zero,
                        itemBuilder: (context) => <PopupMenuEntry<int>>[
                          PopupMenuItem<int>(
                            padding: EdgeInsets.zero,
                            value: 1,
                            onTap: (){
                              Get.to(()=>TripEditPage());
                            },
                            child: Padding(
                              padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(child: SvgPicture.asset('assets/icon/pencil.svg',colorFilter: ColorFilter.mode(gray600,BlendMode.srcIn))),
                                  const SizedBox(width: 10,),
                                  Text(
                                    '수정하기',
                                    style: f14Gray800w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const PopupMenuDivider(height: 3),
                        ])
                        :const SizedBox(width: 24)
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${DateFormat('yyyy.MM.dd').format(DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']))}', style: f12Gray600w500),
                    Text(' ~ ', style: f12Gray600w500),
                    Text('${DateFormat('yyyy.MM.dd').format(DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['endDate']))}', style: f12Gray600w500)
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>MemberList());
                      },
                      child: Container(
                        decoration: ts.selectTripList[0]['type']=='J'
                            ?BoxDecoration(
                            color: gray200,
                            borderRadius: BorderRadius.circular(100),
                            border: (js.jPlanList.isNotEmpty &&
                                ((js.jPlanList[0]['waitList'] ?? []).isNotEmpty ||
                                    js.jPlanList[0]['checked'] == false))
                                ? Border.all(color: gray900, width: 1.5)
                                : null
                        )
                            :BoxDecoration(
                              color: gray200,
                              borderRadius: BorderRadius.circular(100),
                              border: (ps.pPlanList.isNotEmpty &&
                                  ((ps.pPlanList[0]['waitList'] ?? []).isNotEmpty ||
                                      ps.pPlanList[0]['checked'] == false))
                                  ? Border.all(color: gray900, width: 1.5)
                                  : null
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icon/userIcon.svg', color: gray900,),
                              const SizedBox(width: 7,),
                              Text('${ts.selectTripList[0]['tripMemberDtoList'].length}', style: f14Gray900w700,),
                              const SizedBox(width: 5,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if(_currentIndex == 0&&ts.selectTripList[0]['type']=='P')
                  Container(
                    height: 16,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                  ),
              ],
            ),
          )),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: _widgetOptions,
          controller: _bottomTabController,
        ),
        bottomNavigationBar: Container(
          height: 70,
          child: TabBar(
            onTap: (index){
              /// J형 편집 종료
              if(ts.selectTripList[0]['type']=='J'){
                if(js.jPlanList.isNotEmpty && (js.jPlanList[0]['waitList'] ?? []).isEmpty && js.jPlanList[0]['checked'] == false){
                  _bottomTabController.index = 0;
                  showConfirmCancelTapDialog(context, '편집을 종료하시겠습니까?', '확인', null, ()async{
                    js.jPlanList[0]['checked'] = true;
                    js.isSorting.value = false;
                    _currentIndex = index;
                    _bottomTabController.index = index;
                    js.deleteSwapJPlan(js.editPlanJList[0]['dayAfterStart']);
                    setState(() {});
                    Get.back();
                  });
                }else{
                  _currentIndex = index;
                  setState(() {});
                }
              }
              /// P형 편집 종료
              if(ts.selectTripList[0]['type']=='P'){
                if(ps.pPlanList[0]['waitList'].length==0 && ps.pPlanList[0]['checked']==false){
                  _bottomTabController.index = 0;
                  showConfirmCancelTapDialog(context, '편집을 종료하시겠습니까?', '확인', null, ()async{
                    ps.pPlanList[0]['checked'] = true;
                    ps.isSorting.value = false;
                    _currentIndex = index;
                    _bottomTabController.index = index;
                    ps.deleteReorderPPlan(ps.ReorderPPlanList[0]['week']);
                    setState(() {});
                    Get.back();
                  });
                }else{
                  _currentIndex = index;
                  setState(() {});
                }
              }
            },
            controller: _bottomTabController,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.transparent, width: 0), // 투명 밑줄
              ),
            ),
            dividerColor: Colors.transparent,
            unselectedLabelStyle: f10w500,
            labelStyle: f10w500,
            labelColor: gray900,
            unselectedLabelColor: gray300,
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.only(bottom: 20,top: 5),
            indicatorPadding: EdgeInsets.zero,
            tabs: <Widget>[
              Tab(
                icon: SvgPicture.asset(
                  'assets/bottomNavi/schedule.svg',
                  width: 18,
                  height: 19,
                  color: _currentIndex == 0 ? gray900 : gray300,
                ),
                iconMargin: EdgeInsets.only(bottom: 3),
                text: '여행 일정',
              ),
              Tab(
                icon: SvgPicture.asset(
                  'assets/bottomNavi/locker.svg',
                  width: 20,
                  height: 16,
                  color: _currentIndex == 1 ? gray900 : gray300,
                ),
                iconMargin: EdgeInsets.only(bottom: 3),
                text: '보관함',
              ),
              Tab(
                icon: SvgPicture.asset(
                  'assets/bottomNavi/tripHistory.svg',
                  width: 24,
                  height: 24,
                  color: _currentIndex == 2 ? gray900 : gray300,
                ),
                iconMargin: EdgeInsets.only(bottom: 3),
                text: '여행 기록',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

