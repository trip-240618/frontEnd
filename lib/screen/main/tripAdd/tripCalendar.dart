import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import '../../../component/bottomContainer.dart';

class TripCalendar extends StatefulWidget {
  const TripCalendar({super.key});

  @override
  State<TripCalendar> createState() => _TripCalendarState();
}

class _TripCalendarState extends State<TripCalendar> {
  final _scrollController = ScrollController();
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    // DateTime(1999, 5, 6),
    // DateTime(1999, 5, 21),
  ];
  DateTime? startTime;
  DateTime? endTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '', onTap: (){Get.back();}),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('여행 시작일과 종료일을',style: f20gray900w700,),
            Text('설정해 주세요',style: f20gray900w700,),
            const SizedBox(height: 30,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      // 선택된 날짜들 사이의 색
                      dayTextStyle: f14gray800w700,
                      selectedRangeHighlightColor:gray200,
                      todayColor: Color(0xff647AED),
                      dayMaxWidth: 64,
                      dayBorderRadius : BorderRadius.circular(4),
                      controlsHeight: 0,
                      // 오늘 날짜의 텍스트 스타일
                      todayTextStyle: f14Whitew700,
                      monthTextStyle: f16gray800w700,
                      selectedDayTextStyle: f14Whitew700,
                      controlsTextStyle: f12gray900w700,
                      hideScrollViewTopHeader: true,
                      weekdayLabels: ['일', '월', '화', '수', '목', '금', '토'],
                        weekdayLabelTextStyle: f12gray400w500,
                        calendarViewScrollPhysics: const ScrollPhysics(),
                        calendarType: CalendarDatePicker2Type.range,
                     calendarViewMode: CalendarDatePicker2Mode.scroll,
                    ),
                    value: _rangeDatePickerValueWithDefaultValue),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 42),
          child: BlackBottomContainer(onTap: (){}, title: '저장'),
        ),
      ),
    );
  }
}
