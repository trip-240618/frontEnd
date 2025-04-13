import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/trip/locker/planB/jPlanB.dart';
import 'package:tripStory/view/trip/locker/planB/pPlanB.dart';
import 'package:tripStory/view/trip/locker/scrap/scrapPage.dart';


class LockerTapPage extends StatefulWidget {
  const LockerTapPage({super.key});

  @override
  State<LockerTapPage> createState() => _LockerTapPageState();
}

class _LockerTapPageState extends State<LockerTapPage> with TickerProviderStateMixin{
  late TabController _tabController;
  final ts = Get.put(TripState());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TabBar(
              onTap: (int i) {
                FocusScope.of(context).unfocus();
                setState(() {});
              },
              controller: _tabController,
              indicatorColor: Colors.transparent,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2.0, // 선의 두께
                  color: gray900,
                ),
              ),
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              overlayColor: MaterialStatePropertyAll(
                Colors.transparent,
              ),
              tabs: [
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: Get.width,
                      child: Center(
                        child: Text(
                          '일정 B안',
                          style: _tabController.index==0?f16gray900w700:f16gray400w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      child: Center(
                        child: Text(
                          '스크랩',
                          style: _tabController.index==1?f16gray900w700:f16gray400w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ts.selectTripList[0]['type']=='J'?JPlanB():PPlanB(),
                ScrapPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
