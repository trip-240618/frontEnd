import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/base_appbar.dart';
import 'package:tripStory/common/button/icon_button.dart';
import 'package:tripStory/common/button/round_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/view/trip/controllers/trip_main_controller.dart';
import 'package:tripStory/view/trip/models/trip_main_state.dart';

class TripMainView extends StatefulWidget {
  final int tripId;

  const TripMainView({
    super.key,
    required this.tripId,
  });

  @override
  State<TripMainView> createState() => _TripMainViewState();
}

class _TripMainViewState extends State<TripMainView> {
  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      Text("111"),
      Text("222"),
      Text("3333"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripMainController>(
      builder: (controller) {
        return Scaffold(
          appBar: _TripRoomAppbar(
            title: "5월",
            tripNaviType: controller.state.selectedTripType,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2, right: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: RoundedBoxButton(
                    icon: SvgIcon(
                      assetPath: IconConstants.tagUser,
                      color: context.color.gray900,
                    ),
                    text: "5",
                    textStyle: context.style.label1Normal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    backgroundColor: context.color.gray200,
                  ),
                ),
              ),
              IndexedStack(
                index: controller.state.selectedTabIndex,
                children: _widgetOptions,
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: context.color.gray200,
                  width: 1,
                ),
              ),
            ),
            child: Theme(
              data: ThemeData(
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                currentIndex: controller.state.selectedTabIndex,
                backgroundColor: context.color.white,
                onTap: (index) => controller.onNaviPressed(index),
                selectedItemColor: context.color.gray900,
                unselectedItemColor: context.color.gray300,
                selectedLabelStyle: context.style.caption1,
                unselectedLabelStyle: context.style.caption1.copyWith(
                  color: context.color.gray300,
                ),
                items: TripNaviType.values.map((tab) {
                  final isSelected = controller.state.selectedTripType == tab;
                  return BottomNavigationBarItem(
                    icon: SvgIcon(
                      assetPath: tab.iconPath,
                      color: isSelected ? context.color.gray900 : context.color.gray300,
                    ),
                    label: tab.title,
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TripRoomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final TripNaviType tripNaviType;
  final String title;

  const _TripRoomAppbar({
    required this.title,
    required this.tripNaviType,
  });

  @override
  Widget build(BuildContext context) {
    if (tripNaviType == TripNaviType.history) {
      return const SizedBox();
    }

    return BaseAppbar(
      color: context.color.white,
      leadingWidth: 54,
      leadingWidget: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 10),
        child: AppIconButton(
          assetPath: IconConstants.home,
          onTap: () {
            Get.back();
          },
        ),
      ),
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: context.style.headline3,
          ),
          const SizedBox(height: 3),
          Text(
            "24.05.10 ~ 24.05.14",
            style: context.style.caption1.copyWith(
              color: context.color.gray600,
            ),
          ),
        ],
      ),
      actionWidget: AppIconButton(
        assetPath: IconConstants.moreHorizon,
        onTap: () => {},
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
