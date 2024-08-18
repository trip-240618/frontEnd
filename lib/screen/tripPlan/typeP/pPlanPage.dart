import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';

class PPlanPage extends StatefulWidget {
  const PPlanPage({super.key});
  @override
  State<PPlanPage> createState() => _PPlanPageState();
}

class _PPlanPageState extends State<PPlanPage> {
  /// Text Con
  List<TextEditingController> _controllers = [];
  DateTime startDay = DateTime(2024, 5, 10);
  DateTime endDay = DateTime(2024, 5, 14);
  final DateFormat formatter = DateFormat('yyyy.MM.dd', 'ko_KR');
  bool isEdit = false;
  List dates = [];
  List planList = [
    {'date':'2024-05-10','content':'항공편 KE371 도쿄행 인천 출발0', 'checked':true},
    {'date':'2024-05-11','content':'항공편 KE371 도쿄행 인천 출발1', 'checked':false},
    {'date':'2024-05-11','content':'항공편 KE371 도쿄행 인천 출발2', 'checked':true},
    {'date':'2024-05-11','content':'항공편 KE371 도쿄행 인천 출발3', 'checked':true},
    {'date':'2024-05-11','content':'항공편 KE371 도쿄행 인천 출발4', 'checked':true},
    {'date':'2024-05-11','content':'항공편 KE371 도쿄행 인천 출발5', 'checked':false},
    {'date':'2024-05-12','content':'항공편 KE371 도쿄행 인천 출발6', 'checked':false},
    {'date':'2024-05-13','content':'항공편 KE371 도쿄행 인천 출발7', 'checked':false},];
  List value = [];


  @override
  void initState() {
    value = generateDateRange(startDay, endDay);
    ListSort(planList, value);
    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }

  void initControllers() {
    _controllers = List.generate(planList.length, (index) => TextEditingController(text: planList[index]['content'],));
    setState(() {});
  }

  int differenceDayCnt(String day){
    DateTime date = DateTime.parse(day);
    Duration difference = date.difference(startDay);
    print('차이???${difference.inDays}');
    return (difference.inDays)+1;
  }


  /// 'M월/d일(E)' 포멧터
  String customDateFormat1(String dateString){
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('M월/d일(E)', 'ko').format(date);
    return formattedDate;
  }
  /// 시작일, 종료일 사이의 날짜를 리스트로 생성
  List generateDateRange(DateTime startDay, DateTime endDay) {
    List dateList = [];
    for (DateTime date = startDay; date.isBefore(endDay.add(Duration(days: 1))); date = date.add(Duration(days: 1))) {
      dateList.add(DateFormat('yyyy-MM-dd').format(date));
    }
    return dateList;
  }

  /// +Day 버튼을 클릭시 해당 하는 날짜의 맨 밑에 플랜이 추가된다.
  void addPlan(String day){
    /// 'Day'와 숫자를 분리
    String dayPrefix = day.replaceAll(RegExp(r'\d'), ''); // 'Day'
    int dayNumber = int.parse(day.replaceAll(RegExp(r'\D'), '')); // 숫자 부분

    int incrementedDayNumber = dayNumber + 1;

    int addIndex = dates.indexWhere((element) => element['date']=='${dayPrefix}${incrementedDayNumber}');
    addIndex != -1?dates.insert(addIndex, {'date':'2024-05-10','content':'', 'checked':false}):dates.add({'date':'2024-05-10','content':'', 'checked':false});

    setState(() {

    });

  }

  void ListSort(List itemList, List value){
    for(int i = 0; i<value.length; i++){
      dates.add({'date':'Day${i+1}', 'day':value[i]});
      for(int j = 0; j<itemList.length; j++){
        if(value[i]==itemList[j]['date']){
          dates.add(itemList[j]);
        }
      }
    }
    print(dates);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        title: Text('5월 도쿄 여행방'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('${formatter.format(startDay)}~${formatter.format(endDay)}',style: f12gray400w500)),
          const SizedBox(height: 8,),
          Expanded(
            child: ReorderableListView.builder(
              shrinkWrap: true,
              itemCount: dates.length,
              buildDefaultDragHandles: false,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  key: Key('${index}'),
                  children: [
                    const SizedBox(height: 12,),
                    ///Day
                    if('${dates[index]['date']}'.contains('Day')) Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(width: 1, color: gray200),
                          bottom: BorderSide(width: 1, color: gray200),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: (){
                                  addPlan('${dates[index]['date']}');
                                }, child: SvgPicture.asset('assets/icon/circlePlus.svg')),
                            const SizedBox(width: 8,),
                            Container(
                              decoration: BoxDecoration(
                                  color: gray300,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 12),
                                child: Text(dates[index]['date'], style: f14Whitew700,),
                              ),
                            ),
                            const SizedBox(width: 4,),
                            Text(customDateFormat1('${dates[index]['day']}'), style: f12gray300w500,),
                          ],
                        ),
                      ),
                    )
                      /// PlanList
                    else Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              dates[index]['checked'] = !dates[index]['checked'];
                              setState(() {
                              });
                            },
                            child: SvgPicture.asset(
                              dates[index]['checked']
                                  ? 'assets/icon/checked.svg'
                                  : 'assets/icon/unchecked.svg',
                            ),
                          ),
                          const SizedBox(width: 12,),
                          GestureDetector(
                              onTap: (){
                                print(_controllers[index-differenceDayCnt('${dates[index]['date']}')].text);
                                setState(() {

                                });
                              },
                              child:Text('${dates[index]['content']}',style: f14Gray400w500,)),
                          Spacer(),
                          ReorderableDragStartListener(
                            index: index,
                            child: Container(
                                height: 20,
                                width: 20,
                                child: SvgPicture.asset('assets/icon/ellipsis.svg')),

                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
              onReorder: (int oldIndex, int newIndex) {

                setState(() {
                  if (oldIndex == 0 || newIndex == 0) {
                    return;
                  }
                  if(oldIndex<newIndex){
                    newIndex -= 1;
                  }
                  var element = dates.removeAt(oldIndex);
                  dates.insert(newIndex,element);
                });
              },
            ),
          ),
          const SizedBox(
            height: 70,
          )
        ],
      ),
    );
  }
}
