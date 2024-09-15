import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Color mainColor = Color(0xff5E91EE);
  FocusNode _focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  bool isEdit = false;
  /// Text Con
  TextEditingController _controller = TextEditingController();
  DateTime startDay = DateTime(2024, 5, 10);
  DateTime endDay = DateTime(2024, 5, 24);
  int dayDifference = 0;
  int selectWeek = 0;
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
    dayDifference = endDay.difference(startDay).inDays + 1;
    print('${dayDifference}');
    dateList = generateDateRange(startDay, endDay);
    ListSort(planList, dateList);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // 포커스 해제 시 동작
        // _saveToDatabase();
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
    String formattedDate = DateFormat('M.d (E)', 'ko').format(date);
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
        isEdit = false;
        setState(() {
        });
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false, //포커스시 바텀시트 안올라옴
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4,),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Container(
                  height: 56,
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: (dayDifference / 7).ceil(),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          selectWeek == index
                              ?  Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width:36,
                                height: 56,
                                decoration: BoxDecoration(
                                    color: Color(0xff5E91EE),
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 4,top: 9),
                                  child: Column(
                                    children: [
                                      Text('week',style: f11whitew600,),
                                      Spacer(),
                                      Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white
                                          ),
                                          child: Center(child: Text('${index+1}',style: f14gray800w700,)))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                              :  GestureDetector(
                            onTap:(){
                              selectWeek = index;
                              // scrollToIndex(index);
                              setState(() {});
                            },
                            child: Container(
                              width:36,
                              height: 56,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 4,top: 9),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('week',style: f11gray300w600,),
                                    Spacer(),
                                    Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: gray300
                                        ),
                                        child: Center(child: Text('${index+1}',style: f14Whitew700,)))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12)
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Container(
                color: gray50,
                child: ReorderableListView.builder(
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
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Color(0xff5E91EE), width: 1.5
                                      ),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 12),
                                    child: Text(plans[index]['day'], style: f12mainw700(Color(0xff5E91EE)),),
                                  ),
                                ),
                                const SizedBox(width: 6,),
                                Text(customDateFormatter2('${plans[index]['date']}'), style: f14Gray800w500,),
                                Spacer(),
                                GestureDetector(
                                    onTap: (){
                                      print('클릭클릭');
                                      isEdit = true;
                                      _focusNode.requestFocus();
                                      //addPlan(index);
                                      setState(() {

                                      });
                                    }, child: isEdit?SvgPicture.asset('assets/icon/disabledRoundPlus.svg'):SvgPicture.asset('assets/icon/enabledRoundPlus.svg'),),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16,),

                      ],
                    ):
                        /// 플랜리스트
                        Column(
                          key: Key('${index}'),
                          children: [
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
                                        // _saveToDatabase();
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
                                  child: plans[index]['checked']
                                      ? Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(2),
                                            color: mainColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 5, right: 5, top: 7, bottom: 6),
                                            child: SvgPicture.asset(
                                              'assets/icon/check2.svg',
                                            ),
                                          ),
                                  )
                                      : SvgPicture.asset('assets/icon/unchecked.svg',),
                                ),
                                const SizedBox(width: 8,),
                                ReorderableDragStartListener(
                                    index : index,
                                    child: Text('${plans[index]['content']}${index}',style: f14Gray800w500,)),
                                Spacer(),
                                Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 9),
                                      child: SvgPicture.asset('assets/icon/rowEllipsis.svg'),
                                    )),
                              ],),
                            ),
                            const SizedBox(height: 12,),
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
              ),
              const SizedBox(
                height: 200,
              )
            ],
          ),
        ),
        bottomSheet: isEdit?
        Container(
          height: 76,
          decoration: BoxDecoration(
            color: Colors.white, // 배경 색상
            boxShadow: [
              BoxShadow(
                color: Color(0x1AD4D4D4),
                offset: Offset(0, -3),
                blurRadius: 6, // 블러 정도
              ),
              BoxShadow(
                color: Color(0x17D4D4D4),
                offset: Offset(0, -10),
                blurRadius: 10,
              ),
              BoxShadow(
                color: Color(0x0DD4D4D4),
                offset: Offset(0, -23),
                blurRadius: 14,
              ),
              BoxShadow(
                color: Color(0x03D4D4D4),
                offset: Offset(0, -40),
                blurRadius: 16,
              ),
              BoxShadow(
                color: Color(0x00D4D4D4),
                offset: Offset(0, -63),
                blurRadius: 18,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: gray50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: gray200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (con){
                          setState(() {});
                        },
                        cursorColor: mainColor,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: '여행 일정을 입력해주세요',
                          hintStyle: f15gray400w500,
                        ),
                        controller: _controller,
                        focusNode: _focusNode,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(18),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Text('${_controller.text.length}', style: _controller.text.length>0?f11Gray800w600:f11Gray400w600,),
                    Text('/18 ', style: f11Gray400w600,),
                    const SizedBox(width: 8,),
                    SvgPicture.asset('assets/icon/roundArrowRight.svg')

                  ],
                ),
              ),
            ),
          ),
        ):null,
      ),
    );
  }
}
