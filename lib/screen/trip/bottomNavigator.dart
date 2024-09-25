import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/screen/trip/tripHistory/tripHistoryMain.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/jSchedulePage.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';

import 'locker/scrap/scrapPage.dart';

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
  @override
  void initState() {

    _widgetOptions = [JSchedulePage(), ScrapPage(), TripHistoryMainPage()];
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
        title: Padding(
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
                      child: SvgPicture.asset('assets/icon/home.svg')),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: gray200,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              'J',
                              style: f12gray400W700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '도쿄 여행방',
                            style: f16gray600w700,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: 24,
                      child: SvgPicture.asset('assets/icon/dot.svg')),
                ],
              ),
              const SizedBox(height: 4),
              Text('2024.05.10 ~ 2024.05.14',style: f12Gray500w500,)
            ],
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: Text('5월 도쿄 여행방'),
      //   leading: GestureDetector(
      //     onTap: () {
      //       Get.back();
      //     },
      //     child: Icon(Icons.arrow_back_ios_new_outlined),
      //   ),
      // ),
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
          labelColor: gray600,
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
                color: _currentIndex == 0 ? gray600 : gray300,
              ),
              iconMargin: EdgeInsets.only(bottom: 3),
              text: '여행 일정',
            ),
            Tab(
              icon: SvgPicture.asset(
                'assets/bottomNavi/locker.svg',
                width: 20,
                height: 16,
                color: _currentIndex == 1 ? gray600 : gray300,
              ),
              iconMargin: EdgeInsets.only(bottom: 3),
              text: '보관함',
            ),
            Tab(
              icon: SvgPicture.asset(
                'assets/bottomNavi/tripHistory.svg',
                width: 24,
                height: 24,
                color: _currentIndex == 2 ? gray600 : gray300,
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

