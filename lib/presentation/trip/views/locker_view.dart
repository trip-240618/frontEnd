import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/enum/locker_tap_type.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/button/floating_plus_button.dart';
import 'package:tripStory/presentation/trip/views/plan_b_view.dart';
import 'package:tripStory/presentation/trip/views/scraps_view.dart';

class LockerView extends StatefulWidget {
  const LockerView({super.key});

  @override
  State<LockerView> createState() => _LockerViewState();
}

class _LockerViewState extends State<LockerView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  LockerTapType _lockerTapType = LockerTapType.planB;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _lockerTapType = LockerTapType.values[_tabController.index];
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TabBar(
              controller: _tabController,
              labelStyle: context.style.body1Normal.copyWith(
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: context.style.body1Normal.copyWith(
                fontWeight: FontWeight.w700,
                color: context.color.gray400,
              ),
              indicatorColor: context.color.gray900,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              overlayColor: const WidgetStatePropertyAll(
                Colors.transparent,
              ),
              tabs: [
                Tab(
                  child: Text(
                    "일정 B안",
                  ),
                ),
                Tab(
                  child: Text(
                    "스크랩",
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                PlanBView(),
                ScrapsView(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingPlusButton(onPressed: () {
        /// TODO AddScrap 테스트 완료 후 바인딩 예정
        Get.toNamed(Routes.scrapCreate);
      }),
    );
  }
}
