import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/screen/tripHistory/tripHistoryMain.dart';
import 'package:tripStory/screen/tripPlan/typeP/pSchedulePage.dart';
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

  @override
  void initState() {
    _widgetOptions = [PSchedulePage(), PSchedulePage(), TripHistoryMainPage()];
    _bottomTabController = TabController(length: 3, vsync: this,initialIndex: 0);
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5월 도쿄 여행방'),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
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

