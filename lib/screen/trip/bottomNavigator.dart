import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/screen/trip/locker/lockerTapPage.dart';
import 'package:tripStory/screen/trip/tripHistory/tripHistoryMain.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/jSchedulePage.dart';
import 'package:tripStory/screen/trip/tripPlan/typeP/pPlanPage.dart';
import 'package:tripStory/screen/trip/trip_edit_page.dart';
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
  @override
  void initState() {

    _widgetOptions = [JSchedulePage(), LockerTapPage(), TripHistoryMainPage()];
    // _widgetOptions = [PPlanPage(), LockerTapPage(), TripHistoryMainPage()];
    _bottomTabController = TabController(length: 3, vsync: this,initialIndex: 0);
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex==2?null:AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 75,
        title: Obx(()=>Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: ()async{
                        await ms.getComingTrip();
                        Get.back();
                      },
                      child: SvgPicture.asset('assets/icon/home.svg', color: gray900,)),
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
                  PopupMenuButton(
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
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          padding: EdgeInsets.zero,
                          value: 1,
                          onTap: (){
                            Get.to(()=>TripEditPage());
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                child: Container(
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
                              const Divider(color: gray200),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          height: 0,
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: [
                              Padding(
                                padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Center(child: SvgPicture.asset('assets/icon/pencil.svg',colorFilter: ColorFilter.mode(gray600,BlendMode.srcIn))),
                                      const SizedBox(width: 10,),
                                      Text(
                                        '삭제하기',
                                        style: f14Gray800w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )])
                ],
              ),
              const SizedBox(height: 2),
              Text('2024.05.10 ~ 2024.05.14',style: f12Gray600w500,),
              Row(
                children: [
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: gray200,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icon/userIcon.svg', color: gray900,),
                          const SizedBox(width: 6,),
                          Text('5', style: f14Gray900w700,),
                          const SizedBox(width: 6,),
                        ],
                      ),
                    ),
                  ),
                ],
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
            _currentIndex = index;
            setState(() {

            });
          },
          controller: _bottomTabController,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.transparent, width: 0), // 투명 밑줄
            ),
          ),
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
    );
  }
}

