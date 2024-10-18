import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/controller/pPlanState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';

import '../../../../controller/socketState.dart';

class PPlanPage extends StatefulWidget {
  const PPlanPage({super.key});
  @override
  State<PPlanPage> createState() => _PPlanPageState();
}

class _PPlanPageState extends State<PPlanPage> {
  final ts = Get.put(TripState());
  final ps = Get.put(PPlanState());
  final socket = Get.put(SocketState());
  FocusNode _focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  bool isEdit = false;
  /// Text Con
  TextEditingController _controller = TextEditingController();
  int totalDays = 1; /// 여행 총 day 수
  int selectWeek = 0;
  int addIndex = -1;

  @override
  void initState() {
    totalDays = DateTime.parse(ts.selectTripList[0]['endDate']).difference(DateTime.parse(ts.selectTripList[0]['startDate'])).inDays+1;
    Future.delayed(Duration.zero,()async{
      await ps.getPPlanList(false);

      print('p 플랜리스트는?${ps.pPlanList.value}');
    });

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
    // print(plans[addIndex]);
    // if(plans[addIndex]['content'] != ''){
    //   int newIndex = addIndex - differenceDayCnt(plans[addIndex]['date']);
    //   print('추가될 인덱스는???${newIndex}');
    //   planList.insert(newIndex,plans[addIndex] );
    //
    // }
    // addIndex = -1;
  }

  int differenceDayCnt(String day){
    DateTime date = DateTime.parse(day);
    Duration difference = date.difference(DateTime.parse(ts.selectTripList[0]['startDate']));
    print('차이???${difference.inDays}');
    return (difference.inDays)+1;
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
     // print(plans[addIndex]);
      _saveToDatabase();
    }



   // print('${plans[index]}');

    ///lastIndex는 추가하려는 Day의 플랜들 중 가장 끝에 있는 리스트의 인덱스
  //  int lastIndex = plans.lastIndexWhere((item) => item['date'] == plans[index]['date']);
  //   int newIndex = lastIndex+1;
  //   print('추가할 인덱스${newIndex}');
  //
  //   /// 추가될 newIndex가 기존 리스트의 크기보다 작을경우 newIndex 위치에 insert
  //   if(newIndex<plans.length){
  //     int order = plans[lastIndex].containsKey('order')?(plans[lastIndex]['order']):0;
  //     plans.insert(newIndex, {'date':plans[index]['date'],'content':'', 'checked':false,'order':order});
  //     addIndex = newIndex;
  //     _controller.text = '';
  //     _focusNode.requestFocus();
  //   }
  //   /// 추가될 newIndex가 기존 리스트의 크기 이상일 경우 add
  //   else{
  //     plans.add({'date':plans[index]['date'],'content':'', 'checked':false,'order':0});
  //     addIndex = index+1;
  //     print('add??${addIndex}');
  //     _controller.text = '';
  //     _focusNode.requestFocus();
  //   }
  //   print(plans);
  //   setState(() {
  //
  //   });
  }
  void showCustomBottomSheet(BuildContext context) {
    Scaffold.of(context).showBottomSheet((BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x1AD4D4D4),
                offset: Offset(0, -3),
                blurRadius: 6,
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
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (con) {
                          setState(() {});
                        },
                        cursorColor: Colors.blue, // Replace with dynamic color
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
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        controller: _controller,
                        focusNode: _focusNode,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(18),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${_controller.text.length}',
                      style: _controller.text.length > 0
                          ? TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold)
                          : TextStyle(color: Colors.grey[400]),
                    ),
                    Text(
                      '/18 ',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () async {
                        // 여기에 계획 추가 로직
                      },
                      child: Icon(Icons.arrow_forward), // 아이콘은 대체하세요
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
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
        resizeToAvoidBottomInset: false, //포커스시 바텀시트 안올라옴
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              totalDays <=7
              ? const SizedBox()
              : Container(
                color: gray50,
                child: Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Obx(()=>Row(
                    children: [
                      ps.selectedWeekIdx.value > 1
                          ? GestureDetector(
                        onTap: () {
                          if (ps.selectedWeekIdx.value > 1) {
                            ps.selectedWeekIdx.value--;
                          }
                        },
                        child: SvgPicture.asset('assets/icon/leftCaret.svg'),
                      )
                          : const SizedBox(width: 12),
                      const SizedBox(width: 4,),
                      Text('WEEK ${ps.selectedWeekIdx}', style: f14mainw600(Color(ts.selectTripList[0]['labelColor']),)),
                      const SizedBox(width: 4,),
                      totalDays-(ps.selectedWeekIdx.value*7)>0
                          ? GestureDetector(
                          onTap: (){
                            if(totalDays-(ps.selectedWeekIdx.value*7)>0){
                              print('ps.selectedWeekIdx??${ps.selectedWeekIdx.value}');
                              ps.selectedWeekIdx.value ++;
                            }
                          },
                          child: SvgPicture.asset('assets/icon/rightCaret.svg'))
                          :const SizedBox()
                      ,
                    ],
                  ),)
                ),
              ),
              Obx(()=>Container(
                color: gray50,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ps.pPlanList.length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int dayIndex) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            ps.pPlanList[dayIndex]['checked'] = !ps.pPlanList[dayIndex]['checked'];
                            setState(() {

                            });
                          },
                          child: Container(
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
                                            color: Color(ts.selectTripList[0]['labelColor']), width: 1.5
                                        ),
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 12),
                                      child: Text('Day ${ps.pPlanList[dayIndex]['dayAfterStart']}', style: f12mainw700(Color(ts.selectTripList[0]['labelColor']),),),
                                    ),
                                  ),
                                  const SizedBox(width: 6,),
                                  Text('${DateFormat('M.d (E)', 'ko').format(DateTime.parse(ts.selectTripList[0]['startDate']).add(Duration(days: dayIndex)))}', style: f14Gray800w500,),
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
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedSize(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              child: ps.pPlanList[dayIndex]['checked'] == true
                                  ? Padding(
                                padding: ps.pPlanList[dayIndex]['planList'].length==0?EdgeInsets.zero:EdgeInsets.only(top: 16),
                                child: Container(
                                  color: gray50,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: ps.pPlanList[dayIndex]['planList'].length==0?1:ps.pPlanList[dayIndex]['planList'].length,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (context, planIndex) {
                                      return ps.pPlanList[dayIndex]['planList'].length==0?const SizedBox(height: 16,):Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 16,),
                                            GestureDetector(
                                              onTap: () async {
                                                await ps.checkPPlan(ps.pPlanList[dayIndex]['planList'][planIndex]['planId']);
                                                //ps.pPlanList[dayIndex]['planList'][planIndex]['checkbox'] = !ps.pPlanList[dayIndex]['planList'][planIndex]['checkbox'];
                                              },
                                              child: ps.pPlanList[dayIndex]['planList'][planIndex]['checkbox']?
                                              Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(2),
                                                  color: Color(ts.selectTripList[0]['labelColor']),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5, right: 5, top: 7, bottom: 6),
                                                  child: SvgPicture.asset(
                                                    'assets/icon/check2.svg',
                                                  ),
                                                ),
                                              )
                                              :SvgPicture.asset('assets/icon/unchecked.svg',
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Text(
                                                '${ps.pPlanList[dayIndex]['planList'][planIndex]['content']}',
                                                style: f14Gray800w500,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Container(
                                              width: 20,
                                              height: 20,
                                              child: PopupMenuButton<int>(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                  side: BorderSide(color: gray200),
                                                ),
                                                iconSize: 1,
                                                offset: const Offset(-4, 20),
                                                padding: EdgeInsets.zero,
                                                menuPadding: EdgeInsets.zero,
                                                constraints: BoxConstraints(maxWidth: 125),
                                                shadowColor: Colors.black.withOpacity(0.4),
                                                icon: SvgPicture.asset('assets/icon/rowEllipsis.svg'),
                                                color: gray50,
                                                itemBuilder: (context) => <PopupMenuEntry<int>>[
                                                  PopupMenuItem<int>(
                                                    onTap: (){
                                                      ps.selectPPlan.value = ps.pPlanList[dayIndex]['planList'][planIndex];
                                                     // Get.to(()=>EditPlanPage());
                                                    },
                                                    padding: EdgeInsets.zero,
                                                    value: 1,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 12, right: 12),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                'assets/icon/pencil.svg',
                                                                colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                                fit: BoxFit.none,
                                                              ),
                                                              const SizedBox(width: 10),
                                                              Text(
                                                                '일정 수정',
                                                                style: f14Gray800w500,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const PopupMenuDivider(height: 1),
                                                  PopupMenuItem<int>(
                                                    onTap: () async {
                                                      print('난 이걸 지울거야${ps.pPlanList[dayIndex]['planList'][planIndex]}');
                                                      await ps.deletePPlan(ps.pPlanList[dayIndex]['planList'][planIndex]['planId'], ps.pPlanList[dayIndex]['planList'][planIndex]['dayAfterStart']);
                                                    },
                                                    padding: EdgeInsets.zero,
                                                    value: 2,
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            width:24,
                                                            height:24,
                                                            child: SvgPicture.asset(
                                                              'assets/icon/trashCan.svg',
                                                              fit: BoxFit.none,
                                                              colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10),
                                                          Text(
                                                            '일정 삭제',
                                                            style: f14Gray800w500,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const PopupMenuDivider(height: 1),
                                                  PopupMenuItem<int>(
                                                    padding: EdgeInsets.zero,
                                                    value: 3,
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            width:24,
                                                            height:24,
                                                            child: SvgPicture.asset(
                                                              'assets/bottomNavi/locker.svg',
                                                              fit: BoxFit.none,
                                                              colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10),
                                                          Text(
                                                            '보관함 이동',
                                                            style: f14Gray800w500,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                                  : const SizedBox(height: 16,),
                            )
                          ],
                        )
                      ],
                    );
                  },
                ),
              )),
              const SizedBox(
                height: 200,
              )
            ],
          ),
        ),
        // bottomSheet: isEdit?
        // Container(
        //   width: Get.width,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Color(0x1AD4D4D4),
        //         offset: Offset(0, -3),
        //         blurRadius: 6,
        //       ),
        //       BoxShadow(
        //         color: Color(0x17D4D4D4),
        //         offset: Offset(0, -10),
        //         blurRadius: 10,
        //       ),
        //       BoxShadow(
        //         color: Color(0x0DD4D4D4),
        //         offset: Offset(0, -23),
        //         blurRadius: 14,
        //       ),
        //       BoxShadow(
        //         color: Color(0x03D4D4D4),
        //         offset: Offset(0, -40),
        //         blurRadius: 16,
        //       ),
        //       BoxShadow(
        //         color: Color(0x00D4D4D4),
        //         offset: Offset(0, -63),
        //         blurRadius: 18,
        //       ),
        //     ],
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        //     child: Container(
        //       width: Get.width,
        //       decoration: BoxDecoration(
        //         color: gray50,
        //         borderRadius: BorderRadius.circular(4),
        //         border: Border.all(color: gray200),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.all(16),
        //         child: Row(
        //           children: [
        //             Expanded(
        //               child: TextFormField(
        //                 onChanged: (con){
        //                   setState(() {});
        //                 },
        //                 cursorColor: Color(ts.selectTripList[0]['labelColor']),
        //                 decoration: InputDecoration(
        //                   isDense: true,
        //                   contentPadding: EdgeInsets.zero,
        //                   enabledBorder: OutlineInputBorder(
        //                     borderSide: BorderSide.none,
        //                   ),
        //                   focusedBorder: OutlineInputBorder(
        //                     borderSide: BorderSide.none,
        //                   ),
        //                   hintText: '여행 일정을 입력해주세요',
        //                   hintStyle: f15gray400w500,
        //                 ),
        //                 controller: _controller,
        //                 focusNode: _focusNode,
        //                 inputFormatters: <TextInputFormatter>[
        //                   LengthLimitingTextInputFormatter(18),
        //                 ],
        //               ),
        //             ),
        //             const SizedBox(width: 10,),
        //             Text('${_controller.text.length}', style: _controller.text.length>0?f11Gray800w600:f11Gray400w600,),
        //             Text('/18 ', style: f11Gray400w600,),
        //             const SizedBox(width: 8,),
        //             GestureDetector(
        //                 onTap: () async {
        //                   await ps.addPPlanList(_controller.text, 2, false);
        //                 },
        //                 child: SvgPicture.asset('assets/icon/roundArrowRight.svg'))
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ):null,
      ),
    );
  }
}
