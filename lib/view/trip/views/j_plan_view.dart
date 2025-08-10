import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/common/button/icon_button.dart';
import 'package:tripStory/common/button/tab/tab_day.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/common/popup/pop_up_menu.dart';
import 'package:tripStory/common/toast/custom_toast.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/extension/date_extension.dart';
import 'package:tripStory/util/extension/string_extension.dart';
import 'package:tripStory/view/trip/controllers/j_plan_controller.dart';
import 'package:tripStory/view/trip/models/j_plan_state.dart';
import 'package:tripStory/view/trip/widgets/j_plan_list_tile.dart';

class JPlanView extends StatefulWidget {
  const JPlanView({
    super.key,
  });

  @override
  State<JPlanView> createState() => _JPlanViewState();
}

class _JPlanViewState extends State<JPlanView> {
  ScrollController scrollController = ScrollController();
  final controller = Get.find<JPlanController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _WeekSection(),
            const SizedBox(height: 15),
            _MapSection(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GetBuilder<JPlanController>(
                builder: (controller) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final name = controller.state.showToast?.consume();
                    if (name != null && context.mounted) {
                      showWaitToast(context, name);
                    }
                  });
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TabDay(
                              label: "Day ${controller.state.selectedDay}",
                              color: controller.tripRoomInfo?.labelColor.toColor() ?? context.color.blue,
                            ),
                            const Spacer(),
                            AppIconButton(
                              assetPath: IconConstants.plane,
                              onTap: () => controller.onFlightPressed(),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            AppIconButton(
                              assetPath: IconConstants.swap,
                              onTap: () => controller.onPlanSwapPressed(),
                              color: context.color.gray700,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: controller.listController,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                              bottom: 40,
                            ),
                            itemCount: controller.state.plansLength,
                            itemBuilder: (context, index) {
                              final plan = controller.state.plans[index];

                              return Column(
                                children: [
                                  JPlanListTile(
                                    startTime: plan.startTime.formatDeleteSecondTime,
                                    title: plan.title,
                                    memo: plan.memo,
                                    labelColor: controller.tripRoomInfo?.labelColor.toColor() ?? context.color.white,
                                    onTap: () {
                                      // todo: 좌표있으면 해당 지도위치로 이동하는 함수
                                    },
                                    trailing: MultiPopUpMenu(
                                      icon: IconConstants.smallVertical,
                                      items: [
                                        PopupMenuAction(
                                          title: "일정 수정",
                                          onTap: () => controller.onEditPlanPressed(plan),
                                          iconPath: IconConstants.pencil,
                                        ),
                                        PopupMenuAction(
                                          title: "일정 삭제",
                                          onTap: () => controller.onPlanDeletePressed(plan.planId),
                                          iconPath: IconConstants.delete,
                                        ),
                                        PopupMenuAction(
                                          title: "보관함 이동",
                                          onTap: () => controller.onMoveToLockerPressed(plan),
                                          iconPath: IconConstants.inbox,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4)
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GetBuilder<JPlanController>(
        builder: (controller) {
          return _FloatingButton(
            onPressed: () => controller.onAddPlanPressed(),
          );
        },
      ),
    );
  }

  void showWaitToast(
    BuildContext context,
    String message,
  ) {
    CustomToast.show(
      context: context,
      message: message,
    );
  }
}

class _DayContainer extends StatelessWidget {
  final String week;
  final String day;
  final String color;
  final bool isActive;
  final VoidCallback onPressed;

  const _DayContainer({
    required this.color,
    required this.onPressed,
    required this.week,
    required this.day,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isActive ? null : onPressed,
      child: Container(
        width: 36,
        height: 54,
        decoration: BoxDecoration(
          color: isActive ? color.toColor() : context.color.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 4,
            top: 4,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                week,
                style: context.style.caption1.copyWith(
                  color: isActive ? context.color.white : context.color.gray300,
                ),
              ),
              Spacer(),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? context.color.white : context.color.gray300,
                ),
                child: Center(
                  child: Text(
                    day,
                    style: context.style.label1Normal.copyWith(
                      color: isActive ? context.color.gray800 : context.color.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeekSection extends StatelessWidget {
  const _WeekSection();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JPlanController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SizedBox(
            height: 54,
            child: ListView.builder(
              controller: controller.dayScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: controller.tripRoomInfo?.durationDays ?? 0,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final date = controller.tripRoomInfo?.startDate.add(Duration(days: index));

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    children: [
                      _DayContainer(
                        color: controller.tripRoomInfo?.labelColor ?? "",
                        week: date?.weekKo ?? "",
                        day: date?.dayKo ?? "",
                        isActive: index == controller.state.selectedDayIndex,
                        onPressed: () => controller.onDayPressed(index, date),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _MapSection extends StatelessWidget {
  const _MapSection();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JPlanController>(
      builder: (controller) {
        if (controller.state.jPlanStatus == JPlanStatus.initial) {
          return const SizedBox.shrink();
        }
        return Column(
          children: [
            SizedBox(
              width: Get.width,
              height: controller.state.googleMapHeight,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    controller.state.mapLatitude,
                    controller.state.mapLongitude,
                  ),
                  zoom: 14.4746,
                ),
                polylines: Set<Polyline>.of(controller.state.polylines),
                markers: controller.state.markers,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController mapController) {
                  if (!controller.mapController.isCompleted) {
                    controller.mapController.complete(mapController);
                  }
                },
              ),
            ),
            GestureDetector(
              onPanUpdate: (details) => controller.onMapDrag(details.delta.dy),
              child: Container(
                decoration: BoxDecoration(
                  color: context.color.white,
                  border: Border(
                    top: BorderSide(color: context.color.gray200),
                    bottom: BorderSide(color: context.color.gray200),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Container(
                      width: 54,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: context.color.gray400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _FloatingButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: FloatingActionButton(
        heroTag: "add",
        onPressed: onPressed,
        shape: CircleBorder(),
        backgroundColor: context.color.gray900,
        child: SvgIcon(
          assetPath: IconConstants.mainPlus,
          color: context.color.white,
        ),
      ),
    );
  }
}
