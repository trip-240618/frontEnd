import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/common/button/icon_button.dart';
import 'package:tripStory/common/button/round_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/common/popup/pop_up_menu.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/extension/date_extension.dart';
import 'package:tripStory/util/extension/string_extension.dart';
import 'package:tripStory/view/trip/controllers/j_plan_controller.dart';
import 'package:tripStory/view/trip/models/j_plan_state.dart';

class JPlanView extends StatefulWidget {
  const JPlanView({
    super.key,
  });

  @override
  State<JPlanView> createState() => _JPlanViewState();
}

class _JPlanViewState extends State<JPlanView> {
  ScrollController scrollController = ScrollController();
  FToast? fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast?.init(context);
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            RoundedBoxButton(
                              text: "Day ${controller.state.selectedDay}",
                              textStyle: context.style.label1Normal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              backgroundColor: context.color.white,
                              borderColor: controller.tripRoomInfo?.labelColor.toColor() ?? context.color.blue,
                            ),
                            const Spacer(),
                            AppIconButton(
                              assetPath: IconConstants.plane,
                              onTap: () => Get.back(),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            AppIconButton(
                              assetPath: IconConstants.swap,
                              onTap: () => Get.back(),
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
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      // todo: 좌표있으면 해당 지도위치로 이동하는 함수
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 58,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: context.color.gray200,
                                            border: Border.all(
                                              color: context.color.gray200,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              plan.startTime.formatDeleteSecondTime,
                                              style: context.style.caption1,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: context.color.gray200,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(4),
                                                bottomRight: Radius.circular(4),
                                                bottomLeft: Radius.circular(0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  _MemoPopupMenu(
                                                    memo: plan.memo,
                                                    color: controller.tripRoomInfo?.labelColor.toColor() ??
                                                        context.color.white,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      plan.title,
                                                      style: context.style.caption1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  MultiPopUpMenu(
                                                    icon: IconConstants.smallVertical,
                                                    items: [
                                                      PopupMenuAction(
                                                        title: "일정 수정",
                                                        onTap: () {},
                                                        iconPath: IconConstants.pencil,
                                                      ),
                                                      PopupMenuAction(
                                                        title: "일정 삭제",
                                                        onTap: () {},
                                                        iconPath: IconConstants.delete,
                                                      ),
                                                      PopupMenuAction(
                                                        title: "보관함 이동",
                                                        onTap: () {},
                                                        iconPath: IconConstants.inbox,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
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

class _MemoPopupMenu extends StatelessWidget {
  final String? memo;
  final Color color;

  const _MemoPopupMenu({
    required this.memo,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (memo == null || memo!.isEmpty) return const SizedBox();

    return PopupMenuButton(
      offset: const Offset(-34, 35),
      shadowColor: context.color.black.withValues(alpha: 0.4),
      shape: _TooltipShape(borderColor: color),
      color: context.color.white,
      itemBuilder: (_) => [
        PopupMenuItem(
          enabled: false,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            memo!,
            style: context.style.caption1.copyWith(
              color: color,
            ),
          ),
        ),
      ],
      child: SvgIcon(
        assetPath: IconConstants.memo,
        color: color,
      ),
    );
  }
}

class _TooltipShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;

  static const double arrowHeight = 10.0;
  static const double arrowPosition = 43.0;

  const _TooltipShape({
    required this.borderColor,
    this.borderWidth = 2.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  ShapeBorder scale(double t) {
    return _TooltipShape(
      borderColor: borderColor,
      borderWidth: borderWidth * t,
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final rRect = borderRadius.resolve(textDirection).toRRect(rect);
    return Path()..addRRect(rRect.deflate(borderWidth));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final rrect = borderRadius.resolve(textDirection).toRRect(rect);
    final width = rrect.width;
    final height = rrect.height;

    final path = Path();

    // 화살표
    path.moveTo(arrowPosition + borderWidth + 10, borderWidth);
    path.lineTo(arrowPosition + borderWidth, -arrowHeight);
    path.lineTo(arrowPosition - 10 + borderWidth, borderWidth);

    // 왼쪽 상단 모서리
    path.lineTo(borderWidth + 10, borderWidth);
    path.quadraticBezierTo(borderWidth, borderWidth, borderWidth, borderWidth + 4);
    path.lineTo(borderWidth, height - 4 - borderWidth);
    path.quadraticBezierTo(borderWidth, height - borderWidth, borderWidth + 4, height - borderWidth);

    // 아래, 오른쪽
    path.lineTo(width - 4 - borderWidth, height - borderWidth);
    path.quadraticBezierTo(width - borderWidth, height - borderWidth, width - borderWidth, height - 4 - borderWidth);
    path.lineTo(width - borderWidth, borderWidth + 4);
    path.quadraticBezierTo(width - borderWidth, borderWidth, width - 4 - borderWidth, borderWidth);

    path.lineTo(arrowPosition + borderWidth + 10, borderWidth);
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawPath(getOuterPath(rect, textDirection: textDirection), paint);
  }
}
