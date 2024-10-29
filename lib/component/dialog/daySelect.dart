import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/controller/jPlanState.dart';
import '../../controller/tripState.dart';
import 'package:tripStory/controller/historyState.dart';
import '../../screen/trip/tripHistory/album/albumPage.dart';
import '../../util/color.dart';
import '../../util/font.dart';

SelectDayDialog(BuildContext context, String title, VoidCallback onTap) {
  final ts = Get.put(TripState());
  final hs = Get.put(HistoryState());
  String? selectedDate;
  final List<String> dateList = List.generate(
      DateTime.parse('${ts.selectTripList[0]['endDate']}').difference(DateTime.parse('${ts.selectTripList[0]['startDate']}')).inDays + 1, (index) => DateFormat('yyyy.MM.dd (EEE)', 'ko').format(
      DateTime.parse('${ts.selectTripList[0]['startDate']}').add(Duration(days: index)),
    ),
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  content: Container(
                    width: Get.width,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '등록하려는 사진의',
                                style: f18gray900w600,
                              ),
                              Text('여행 날짜를 선택해주세요', style: f18gray900w600),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10), // 상단 여백
                        Expanded(
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: dateList.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, idx) {
                              return RadioListTile<String>(
                                title: Row(
                                  children: [
                                    Text(dateList[idx], style: f16gray800w500),
                                  ],
                                ),
                                value: dateList[idx],
                                contentPadding: EdgeInsets.zero,
                                groupValue: selectedDate,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedDate = newValue; // 선택된 날짜 업데이트
                                  });
                                },
                                dense: true,
                                hoverColor: gray900,
                                controlAffinity: ListTileControlAffinity.leading,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                fillColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.disabled)) {
                                      return gray400.withOpacity(.32);
                                    } else if (states.contains(MaterialState.selected)) {
                                      return gray900;
                                    }
                                    return gray400.withOpacity(.32);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              height: 58,
                              decoration: BoxDecoration(
                                color: gray200,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  '취소',
                                  style: f16gray600w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12,),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if(selectedDate !=null){
                                Get.back();
                                hs.selectedDate.value = selectedDate!;
                                Get.to(()=>AlbumPage());
                              }else{
                                showOnlyConfirmTapDialog(context, '날짜를 선택해주세요', (){
                                  Get.back();
                                });
                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Center(
                              child: Container(
                                height: 58,
                                decoration: BoxDecoration(
                                  color: gray900,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    '확인',
                                    style: f16whitew400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }
        );
      }
  );
}

SelectDayBottomSheet(BuildContext context, String title, VoidCallback? onTap){
  final js = Get.put(JPlanState());
  final ts = Get.put(TripState());
  String selectedDate =  DateFormat('yyyy.MM.dd (EEE)', 'ko').format(DateFormat('yyyy-MM-dd').parse(js.selectedDate.value));
  final List<String> dateList = List.generate(
    DateTime.parse('${ts.selectTripList[0]['endDate']}').difference(DateTime.parse('${ts.selectTripList[0]['startDate']}')).inDays + 1, (index) => DateFormat('yyyy.MM.dd (EEE)', 'ko').format(
    DateTime.parse('${ts.selectTripList[0]['startDate']}').add(Duration(days: index)),
  ),
  );
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder){
        return StatefulBuilder(
            builder: (context, StateSetter setState){
              return GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0),
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                                color:greyColor
                            ),
                          ),
                        ),
                        const SizedBox(height: 34,),
                        Text(title, style: f18Gray800w600,),
                        const SizedBox(height: 12,),
                        Expanded(
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: dateList.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, idx) {
                              return RadioListTile<String>(
                                title: Row(
                                  children: [
                                    Text(dateList[idx], style: f16gray800w500),
                                  ],
                                ),
                                value: dateList[idx],
                                contentPadding: EdgeInsets.zero,
                                groupValue: selectedDate,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedDate = newValue!;
                                    js.selectedDate.value = DateFormat('yyyy-MM-dd').format(DateFormat('yyyy.MM.dd (EEE)', 'ko').parse(selectedDate));
                                  });
                                },
                                dense: true,
                                hoverColor: gray900,
                                controlAffinity: ListTileControlAffinity.leading,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                fillColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.disabled)) {
                                      return gray400.withOpacity(.32);
                                    } else if (states.contains(MaterialState.selected)) {
                                      return gray900;
                                    }
                                    return gray400.withOpacity(.32);
                                  },
                                ),
                              );
                            },
                          ),
                        ),



                      ],
                    ),
                  ),
                ),

              );
            }

        );
      }

  );


}

SelectDayBottomSheet2(
    BuildContext context,
    String title,
    bool edit
    ){
  final js = Get.put(JPlanState());
  final ts = Get.put(TripState());
  final List<String> dateList = List.generate(
    DateTime.parse('${ts.selectTripList[0]['endDate']}').difference(DateTime.parse('${ts.selectTripList[0]['startDate']}')).inDays + 1, (index) => DateFormat('yyyy.MM.dd (EEE)', 'ko').format(
    DateTime.parse('${ts.selectTripList[0]['startDate']}').add(Duration(days: index)),
    ),
  );
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder){
        return StatefulBuilder(
            builder: (context, StateSetter setState){
              return GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0),
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                                color:greyColor
                            ),
                          ),
                        ),
                        const SizedBox(height: 34,),
                        Text(title, style: f18Gray800w600,),
                        const SizedBox(height: 12,),
                        Expanded(
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: dateList.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, idx) {
                              return RadioListTile<String>(
                                title: Row(
                                  children: [
                                    Text(dateList[idx], style: f16gray800w500),
                                  ],
                                ),
                                value: dateList[idx],
                                contentPadding: EdgeInsets.zero,
                                groupValue: edit?js.editDate.value:js.addDate.value,
                                onChanged: (String? newValue) {
                                  if(edit){
                                    js.editDate.value = newValue!;
                                  }else{
                                    js.addDate.value = newValue!;
                                    js.addDate.refresh();
                                  }
                                  setState((){});
                                },
                                dense: true,
                                hoverColor: gray900,
                                controlAffinity: ListTileControlAffinity.leading,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                fillColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.disabled)) {
                                      return gray400.withOpacity(.32);
                                    } else if (states.contains(MaterialState.selected)) {
                                      return gray900;
                                    }
                                    return gray400.withOpacity(.32);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        );
      }
  );
}
ButtonSelectDayBottomSheet(
    BuildContext context, String title, VoidCallback onTap, String buttonName){
  final js = Get.put(JPlanState());
  final ts = Get.put(TripState());
  final List<String> dateList = List.generate(
    DateTime.parse('${ts.selectTripList[0]['endDate']}').difference(DateTime.parse('${ts.selectTripList[0]['startDate']}')).inDays + 1, (index) => DateFormat('yyyy.MM.dd (EEE)', 'ko').format(
    DateTime.parse('${ts.selectTripList[0]['startDate']}').add(Duration(days: index)),
  ),
  );
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder){
        return StatefulBuilder(
            builder: (context, StateSetter setState){
              return GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0),
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                                color:greyColor
                            ),
                          ),
                        ),
                        const SizedBox(height: 34,),
                        Text(title, style: f18Gray800w600,),
                        const SizedBox(height: 12,),
                        Expanded(
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: dateList.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, idx) {
                              return RadioListTile<String>(
                                title: Row(
                                  children: [
                                    Text(dateList[idx], style: f16gray800w500),
                                  ],
                                ),
                                value: dateList[idx],
                                contentPadding: EdgeInsets.zero,
                                groupValue: js.addDate.value,
                                onChanged: (String? newValue) {

                                  js.addDate.value = newValue!;
                                  js.addDate.refresh();
                                  setState((){});
                                },
                                dense: true,
                                hoverColor: gray900,
                                controlAffinity: ListTileControlAffinity.leading,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                fillColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.disabled)) {
                                      return gray400.withOpacity(.32);
                                    } else if (states.contains(MaterialState.selected)) {
                                      return gray900;
                                    }
                                    return gray400.withOpacity(.32);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        BlackBottomContainer(onTap: onTap, title: buttonName)
                      ],
                    ),
                  ),
                ),

              );
            }

        );
      }

  );


}