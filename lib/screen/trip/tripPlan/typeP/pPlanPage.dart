import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';

class PPlanPage extends StatefulWidget {
  const PPlanPage({super.key});
  @override
  State<PPlanPage> createState() => _PPlanPageState();
}

class _PPlanPageState extends State<PPlanPage> {
  FocusNode _focusNode = FocusNode();
  /// Text Con
  TextEditingController _controller = TextEditingController();
  DateTime startDay = DateTime(2024, 5, 10);
  DateTime endDay = DateTime(2024, 5, 14);
  List plans = [];
  List planList = [
    {'date':'2024-05-10','content':'항공편 KE371 도쿄행 인천 출발', 'checked':true, 'order': 0 },
    {'date':'2024-05-11','content':'도쿄 디즈리랜드', 'checked':false, 'order': 0},
    {'date':'2024-05-11','content':'도쿄타워 보기', 'checked':true, 'order': 1},
    {'date':'2024-05-11','content':'타코야끼 먹기', 'checked':true, 'order': 2},
    {'date':'2024-05-12','content':'멘야무사시 츠케멘', 'checked':false, 'order': 0},
    {'date':'2024-05-13','content':'숙소 체크인', 'checked':false, 'order': 0}];
  List dateList = [];
  int addIndex = -1;

  @override
  void initState() {
    dateList = generateDateRange(startDay, endDay);
    ListSort(planList, dateList);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // 포커스 해제 시 동작
        _saveToDatabase();
      }
    });
    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }

  void _saveToDatabase(){
    print(plans[addIndex]);
    if(plans[addIndex]['content'] != ''){
      int newIndex = addIndex - differenceDayCnt(plans[addIndex]['date']);
      print('추가될 인덱스는???${newIndex}');
      planList.insert(newIndex,plans[addIndex] );

    }
    ListSort(planList, dateList);
    addIndex = -1;

  }
  int differenceDayCnt(String day){
    DateTime date = DateTime.parse(day);
    Duration difference = date.difference(startDay);
    print('차이???${difference.inDays}');
    return (difference.inDays)+1;
  }

  /// yyyy.MM.dd 포멧터
  String customDateFormatter1(String dateString){
    DateTime date = DateTime.parse(dateString);
    String formattedDate =DateFormat('yyyy.MM.dd', 'ko_KR').format(date);
    return formattedDate;
  }


  /// M월/d일(E) 포멧터
  String customDateFormatter2(String dateString){
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

  /// (+) Day 버튼을 클릭시 해당 Day의 맨 밑에 새로운 플랜 추가
  void addPlan(int index){
    FocusScope.of(context).unfocus();
    if(addIndex != -1){
      print('작성하다만거');
      print(plans[addIndex]);
      _saveToDatabase();
    }


    print('${plans[index]}');

    ///lastIndex는 추가하려는 Day의 플랜들 중 가장 끝에 있는 리스트의 인덱스
    int lastIndex = plans.lastIndexWhere((item) => item['date'] == plans[index]['date']);
    int newIndex = lastIndex+1;
    print('추가할 인덱스${newIndex}');

    /// 추가될 newIndex가 기존 리스트의 크기보다 작을경우 newIndex 위치에 insert
    if(newIndex<plans.length){
      int order = plans[lastIndex].containsKey('order')?(plans[lastIndex]['order']):0;
      plans.insert(newIndex, {'date':plans[index]['date'],'content':'', 'checked':false,'order':order});
      addIndex = newIndex;
      _controller.text = '';
      _focusNode.requestFocus();
    }
    /// 추가될 newIndex가 기존 리스트의 크기 이상일 경우 add
    else{
      plans.add({'date':plans[index]['date'],'content':'', 'checked':false,'order':0});
      addIndex = index+1;
      print('add??${addIndex}');
      _controller.text = '';
      _focusNode.requestFocus();
    }
    print(plans);
    setState(() {

    });
  }

  void ListSort(List itemList, List value){
    plans = [];
    for(int i = 0; i<value.length; i++){
      plans.add({'date':value[i], 'day':'Day${i+1}'});
      for(int j = 0; j<itemList.length; j++){
        if(value[i]==itemList[j]['date']){
          plans.add(itemList[j]);
        }
      }
    }
    print('리스트 재정렬');
    //print(plans);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
        setState(() {
        });
      },
      child: Scaffold(
        backgroundColor: gray50,
        appBar: AppBar(
          title: Text('5월 도쿄 여행방'),
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('${customDateFormatter1(startDay.toString())}~${customDateFormatter1(endDay.toString())}',style: f12gray400w500)),
              const SizedBox(height: 8,),
              ReorderableListView.builder(
                shrinkWrap: true,
                itemCount: plans.length,
                buildDefaultDragHandles: false,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return '${plans[index]['day']}'.contains('Day')?
                    /// (+) Day
                    Column(
                    key: Key('${index}'),
                    children: [
                      const SizedBox(height: 12,),
                     Container(
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
                                    print('클릭클릭');
                                    addPlan(index);
                                  }, child: SvgPicture.asset('assets/icon/circlePlus.svg')),
                              const SizedBox(width: 8,),
                              Container(
                                decoration: BoxDecoration(
                                    color: gray300,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 12),
                                  child: Text(plans[index]['day'], style: f14Whitew700,),
                                ),
                              ),
                              const SizedBox(width: 4,),
                              Text(customDateFormatter2('${plans[index]['date']}'), style: f12gray300w500,),
                            ],
                          ),
                        ),
                      )
                    ],
                  ):
                      /// 플랜리스트
                      Column(
                        key: Key('${index}'),
                        children: [
                          const SizedBox(height: 12,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
                            child:
                            /// 새롭게 추가되는 인덱스 일 경우
                            addIndex == index?
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    plans[index]['checked'] = !plans[index]['checked'];
                                    setState(() {
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    plans[index]['checked']
                                        ? 'assets/icon/checked.svg'
                                        : 'assets/icon/unchecked.svg',
                                  ),
                                ),
                                const SizedBox(width: 12,),
                                Expanded(
                                  child: TextFormField(
                                        controller: _controller,
                                        focusNode: _focusNode,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: BorderSide(width: 1.5, color: Color(0xffEBEBEB)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                            borderSide: BorderSide(color: Color(0xff3648EB))),
                                        contentPadding:
                                        EdgeInsets.only(top: 15, bottom: 15, left: 13, right: 13),
                                        hintText: '일정을 입력해주세요',
                                      ),
                                    onChanged:  (value) {
                                      setState(() {
                                        plans[index]['content'] = value;
                                      });
                                    },
                                    onEditingComplete: () {
                                      _saveToDatabase();
                                    },
                                      ),
                                ),
                                Container(
                                    height: 20,
                                    width: 20,
                                    child: SvgPicture.asset('assets/icon/ellipsis.svg')),
                              ],
                            ):Row(children: [
                              GestureDetector(
                                onTap: (){
                                  plans[index]['checked'] = !plans[index]['checked'];
                                  setState(() {
                                  });
                                },
                                child: SvgPicture.asset(
                                  plans[index]['checked']
                                      ? 'assets/icon/checked.svg'
                                      : 'assets/icon/unchecked.svg',
                                ),
                              ),
                              const SizedBox(width: 12,),
                              ReorderableDragStartListener(
                                  index : index,
                                  child: Text('${plans[index]['content']}${index}',style: f14Gray400w500,)),
                              Spacer(),
                              Container(
                                  height: 20,
                                  width: 20,
                                  child: SvgPicture.asset('assets/icon/ellipsis.svg')),
                            ],),
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
                    var element = plans.removeAt(oldIndex);
                    plans.insert(newIndex,element);
                  });
                },
              ),
              const SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
