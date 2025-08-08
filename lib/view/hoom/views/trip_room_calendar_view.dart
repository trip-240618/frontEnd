import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/bottom_button.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/hoom/controller/trip_room_calendar_controller.dart';

class TripRoomCalendarView extends StatefulWidget {
  final bool? edit;
  final Color selectedColor;

  const TripRoomCalendarView({
    super.key,
    this.edit,
    required this.selectedColor,
  });

  @override
  State<TripRoomCalendarView> createState() => _TripRoomCalendarViewState();
}

class _TripRoomCalendarViewState extends State<TripRoomCalendarView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripRoomCalendarController>(
      init: Get.find<TripRoomCalendarController>(),
      builder: (controller) {
        final showDialog = controller.state.showDialog?.consume();
        if (showDialog == true) {
          Future.microtask(() {
            if (context.mounted) {
              showOnlyConfirmTapDialog(
                context,
                "날짜를 선택해주세요",
                () => Get.back(),
              );
            }
          });
        }
        return Scaffold(
          appBar: AppAppbar(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 8,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "여행 시작일과 종료일을\n설정해 주세요",
                      style: f20gray900w700,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "당일 일정도 선택 가능해요:)",
                      style: f12Gray400w600,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Container(
                  color: context.color.gray50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                        dayTextStyle: f14gray800w700,
                        selectedRangeHighlightColor: gray200,
                        dayMaxWidth: 64,
                        dayBorderRadius: BorderRadius.circular(4),
                        controlsHeight: 0,
                        todayTextStyle: f14Whitew700,
                        selectedDayTextStyle: f14Whitew700,
                        controlsTextStyle: f16gray800w700,
                        todayColor: widget.selectedColor,
                        hideScrollViewTopHeader: true,
                        weekdayLabels: ["일", "월", "화", "수", "목", "금", "토"],
                        weekdayLabelTextStyle: f12gray400w500,
                        calendarViewScrollPhysics: const ScrollPhysics(),
                        calendarType: CalendarDatePicker2Type.range,
                        calendarViewMode: CalendarDatePicker2Mode.scroll,
                      ),
                      onValueChanged: (dates) => controller.onCalendarDatesChange(dates),
                      value: controller.state.selectedDates,
                    ),
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: BottomButton(
            text: "저장",
            onTap: () => controller.onSavePressed(),
          ),
        );
      },
    );
  }
}
