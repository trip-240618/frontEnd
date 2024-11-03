import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/controller/pPlanState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import '../../../../component/dialog/loading.dart';
import '../../../../component/toast/toast.dart';
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
  bool isEdit = false; /// 추가, 수정중인지 여부
  /// Text Con
  TextEditingController _controller = TextEditingController();
  int totalDays = 1; /// 여행 총 day 수
  int selectWeek = 0;
  int selectDayIdx = 0;
  FToast? fToast;
  @override
  void initState() {
    fToast = FToast();
    fToast?.init(context);
    ps.totalDays.value = DateTime.parse(ts.selectTripList[0]['endDate']).difference(DateTime.parse(ts.selectTripList[0]['startDate'])).inDays+1;
    print('이게뭐임?${ps.totalDays.value}');
    /// totalday / week*7 이 나머지가 7 이상이면 7, 아니면 나머지만큼
    Future.delayed(Duration.zero,()async{
      await ps.getPPlanList(false);
    });

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        removeLastPlan();
        Navigator.of(context).pop();
        isEdit = false;
      }
    });
    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }


  /// (+) Day 버튼을 클릭시 해당 Day의 맨 밑에 새로운 플랜 추가
  void addPlan(int index){
    FocusScope.of(context).unfocus();
    // if(addIndex != -1){
    //   print('작성하다만거');
    //  // print(plans[addIndex]);
    //   _saveToDatabase();
    // }



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
  /// 일정 추가 바텀 시트
  void showAddBottomSheet(BuildContext context) {
    _controller.clear();
    Scaffold.of(context).showBottomSheet((BuildContext context) {
        return Container(
        width: Get.width,
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
                      cursorColor: Color(ts.selectTripList[0]['labelColor']),
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
                  GestureDetector(
                      onTap: () async {
                        print(_controller.text);
                        print(ps.pPlanList[0]['dayList'][selectDayIdx]['dayAfterStart']);
                        removeLastPlan();
                        await ps.addPPlanList(_controller.text, ps.pPlanList[0]['dayList'][selectDayIdx]['dayAfterStart'], false);
                        Get.back();
                        isEdit = false;
                      },
                      child: SvgPicture.asset('assets/icon/roundArrowRight.svg'))
                ],
              ),
            ),
          ),
        ),
      );
      },
    );
  }

  /// 일정 수정 바텀 시트
  void showEditBottomSheet(BuildContext context) {
    _controller.text = ps.selectPPlan['content'];
    Scaffold.of(context).showBottomSheet((BuildContext context) {
      return Container(
        width: Get.width,
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
                      cursorColor: Color(ts.selectTripList[0]['labelColor']),
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
                  GestureDetector(
                      onTap: () async {
                        if(_controller.text != ''){
                          ps.selectPPlan['content'] = _controller.text;
                          await ps.editPPlanList(ps.selectPPlan.value);
                          Get.back();
                          isEdit = false;
                        }
                      },
                      child: SvgPicture.asset('assets/icon/smallpencil.svg')),
                ],
              ),
            ),
          ),
        ),
      );
    },
    );
  }

  /// 포커스를 벗어나면 임시 추가된 빈 일정 항목을 삭제
  void removeLastPlan(){
    var lastPlan = ps.pPlanList[0]['dayList'][selectDayIdx]['planList'].last;
    if(lastPlan['planId']==null){
      ps.pPlanList[0]['dayList'][selectDayIdx]['planList'].removeLast();
    }
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
          child: Obx(()=>Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ps.totalDays.value <=7
                  ? const SizedBox()
                  : Container(
                      color: gray50,
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Row(
                          children: [
                            ps.selectedWeekIdx.value > 1
                                ? GestureDetector(
                                  onTap: () async {
                                    if (ps.selectedWeekIdx.value > 1) {
                                      ps.selectedWeekIdx.value--;
                                      await ps.getPPlanList(false);
                                    }
                                  },
                                  child: SvgPicture.asset('assets/icon/leftCaret.svg'),
                                )
                                : const SizedBox(width: 12),
                            const SizedBox(width: 4,),
                            Text('WEEK ${ps.pPlanList[0]['week']}', style: f14mainw600(Color(ts.selectTripList[0]['labelColor']),)),
                            const SizedBox(width: 4,),
                            ps.totalDays.value-(ps.selectedWeekIdx.value*7)>0
                                ? GestureDetector(
                                    onTap: () async {
                                      if(ps.totalDays.value-(ps.selectedWeekIdx.value*7)>0){
                                        print('ps.selectedWeekIdx??${ps.selectedWeekIdx.value}');
                                        ps.selectedWeekIdx.value ++;
                                        await ps.getPPlanList(false);
                                      }
                                    },
                                    child: SvgPicture.asset('assets/icon/rightCaret.svg'))
                                :const SizedBox(),
                            Spacer(),
                            InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () async {
                                await socket.pAddEditor(ps.pPlanList[0]['week']);
                                await Future.delayed(const Duration(milliseconds: 100));
                                /// p형 편집중 여부
                                if(ps.pPlanList[0]['waitList'].length!=0){
                                  showCustomToast(context, fToast!, '${ps.pPlanList[0]['waitList']['nickname']} 님이 일정을 수정 중입니다',true);
                                }else{
                                  if(ps.pPlanList[0]['checked']){
                                    ps.isSorting.value = true;
                                    showCustomToast(context, fToast!, '순서를 변경 하고 싶은 일정을 길게 터치해 주세요',true);
                                    ps.pPlanList[0]['checked'] = false;
                                    await ps.makeReorderableList();
                                    ps.isSorting.refresh();
                                  }
                                  /// 편집 종료
                                  else{
                                    showLoading(context);
                                    ps.pPlanList[0]['checked'] = true;
                                    Map<String,dynamic> moveData = await ps.revertList();

                                    await ps.reorderPPlan(moveData);

                                    await ps.deleteReorderPPlan(ps.ReorderPPlanList[0]['week']);
                                    ps.isSorting.value = false;
                                    Get.back();
                                    ps.ReorderPPlanList.value = []; /// 리오더블 초기화
                                  }
                                }


                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                child: SvgPicture.asset('assets/icon/swap.svg',fit: BoxFit.none,colorFilter: ColorFilter.mode(
                                  ps.isSorting.value?gray600:gray400, // 원하는 색상으로 변경
                                  BlendMode.srcIn, // 색상을 적용하는 블렌드 모드
                                ),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
              ps.isSorting.value?
              Container(
                  color: gray50,
                  child: ReorderableListView.builder(
                    shrinkWrap: true,
                    itemCount: ps.ReorderPPlanList[0]['dayList'].length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return ps.ReorderPPlanList[0]['dayList'][index]['type'] == 'day'?
                      Container(
                        key: Key('${index}'),
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
                                  child: Text('Day ${ps.ReorderPPlanList[0]['dayList'][index]['data']}', style: f12mainw700(Color(ts.selectTripList[0]['labelColor']),),),
                                ),
                              ),
                              const SizedBox(width: 6,),
                              Text('${DateFormat('M.d (E)', 'ko').format(DateTime.parse(ts.selectTripList[0]['startDate']).add(Duration(days: int.parse('${ps.ReorderPPlanList[0]['dayList'][index]['data']}')-1)))}', style: f14Gray800w500,),
                            ],
                          ),
                        ),
                      ):
                      Container(
                          key: Key('${index}'),
                          color: gray50,
                          child: Padding(
                            padding: ps.ReorderPPlanList[0]['dayList'][index-1]['type']=='day'?const EdgeInsets.only(left: 20, right: 20,top: 16, bottom: 16):const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16,),
                                ps.ReorderPPlanList[0]['dayList'][index]['data']['checkbox']?
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
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    '${ps.ReorderPPlanList[0]['dayList'][index]['data']['content']}',
                                    style: f14Gray800w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  width: 20,
                                  height: 20,
                                  child: SvgPicture.asset('assets/icon/rowEllipsis.svg'),
                                )
                              ],
                            ),
                          )
                      );
                    }, onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex == 0 || newIndex == 0) {
                      return;
                    }
                    if(oldIndex<newIndex){
                      newIndex -= 1;
                    }
                    final item = ps.ReorderPPlanList[0]['dayList'].removeAt(oldIndex);
                    ps.ReorderPPlanList[0]['dayList'].insert(newIndex, item);
                    print(ps.ReorderPPlanList[0]['dayList'][newIndex]);

                    ps.ReorderPPlanList[0]['dayList'][newIndex]['data']['orderByDate'] = null;
                    ps.ReorderPPlanList[0]['dayList'][newIndex]['data']['dayAfterStart'] =
                    ps.ReorderPPlanList[0]['dayList'][newIndex-1]['type'] == 'day'? ps.ReorderPPlanList[0]['dayList'][newIndex-1]['data']:ps.ReorderPPlanList[0]['dayList'][newIndex-1]['data']['dayAfterStart'];

                    print('리오더블함');
                    print(ps.ReorderPPlanList[0]['dayList']);
                  },
                  )
              )
                  :
              Container(
                color: gray50,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ps.pPlanList[0]['dayList'].length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int dayIndex) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            ps.pPlanList[0]['dayList'][dayIndex]['isExpanded'] = !ps.pPlanList[0]['dayList'][dayIndex]['isExpanded'];
                            ps.pPlanList.refresh();
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
                                      child: Text('Day ${ps.pPlanList[0]['dayList'][dayIndex]['dayAfterStart']}', style: f12mainw700(Color(ts.selectTripList[0]['labelColor']),),),
                                    ),
                                  ),
                                  const SizedBox(width: 6,),
                                  Text('${DateFormat('M.d (E)', 'ko').format(DateTime.parse(ts.selectTripList[0]['startDate']).add(Duration(days: int.parse('${ps.pPlanList[0]['dayList'][dayIndex]['dayAfterStart']}')-1)))}', style: f14Gray800w500,),
                                  Spacer(),
                                  ps.pPlanList[0]['dayList'][dayIndex]['planList'].where((plan) => plan['checkbox'] == true).length == 0
                                      ? const SizedBox(width: 20,)
                                      : Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Color(ts.selectTripList[0]['labelColor']),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Text('${ps.pPlanList[0]['dayList'][dayIndex]['planList'].where((plan) => plan['checkbox'] == true).length}', style: f12Whitew700,),
                                    ),
                                  ),
                                  ps.pPlanList[0]['dayList'][dayIndex]['planList'].where((plan) => plan['checkbox'] == false).length == 0
                                      ? const SizedBox()
                                      : Padding( padding: const EdgeInsets.only(left: 4),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: gray400,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Text('${ps.pPlanList[0]['dayList'][dayIndex]['planList'].where((plan) => plan['checkbox'] == false).length}', style: f12Whitew700,),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: (){
                                      print(dayIndex);
                                      if(isEdit == false){
                                        /// 선택한 day만 펼치고 나머지는 닫기
                                        for (int i = 0; i < ps.pPlanList[0]['dayList'].length; i++) {
                                          ps.pPlanList[0]['dayList'][i]['isExpanded'] = (i == dayIndex);
                                        }
                                        selectDayIdx = dayIndex; /// 이후 포커스 없을때 삭제하기 위해서 인덱스 저장
                                        ps.pPlanList[0]['dayList'][dayIndex]['planList'].add({
                                          'planId': null,
                                          'dayAfterStart': ps.pPlanList[0]['dayList'][dayIndex]['dayAfterStart'],
                                          'orderByDate': 0,
                                          'writerUuid': '',
                                          'content': '',
                                          'checkbox': false,
                                        });
                                        showAddBottomSheet(context);
                                        isEdit = true;
                                        _focusNode.requestFocus();
                                      }
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
                              child: ps.pPlanList[0]['dayList'][dayIndex]['isExpanded'] == true
                                  ? Padding(
                                padding: ps.pPlanList[0]['dayList'][dayIndex]['planList'].length==0?EdgeInsets.zero:EdgeInsets.only(top: 16),
                                child: Container(
                                  color: gray50,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: ps.pPlanList[0]['dayList'][dayIndex]['planList'].length==0?1:ps.pPlanList[0]['dayList'][dayIndex]['planList'].length,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (context, planIndex) {
                                      return ps.pPlanList[0]['dayList'][dayIndex]['planList'].length==0?const SizedBox(height: 16,):Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 16,),
                                            GestureDetector(
                                              onTap: () async {
                                                await ps.checkPPlan(ps.pPlanList[0]['dayList'][dayIndex]['planList'][planIndex]['planId']);
                                                //ps.pPlanList[0]['dayList'][dayIndex]['planList'][planIndex]['checkbox'] = !ps.pPlanList[0]['dayList'][dayIndex]['planList'][planIndex]['checkbox'];
                                              },
                                              child: ps.pPlanList[0]['dayList'][dayIndex]['planList'][planIndex]['checkbox']?
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
                                                '${ps.pPlanList[0]['dayList'][dayIndex]['planList'][planIndex]['content']}',
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
                                                      ps.selectPPlan.value = ps.pPlanList[0]['dayList'][dayIndex]['planList'][planIndex];
                                                      showEditBottomSheet(context);
                                                      _focusNode.requestFocus();
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
                                                      print('난 이걸 지울거야${ps.pPlanList[0]['dayList'][dayIndex]['planList'][planIndex]}');
                                                      await ps.deletePPlan(ps.pPlanList[0]['dayList'][dayIndex]['planList'][planIndex]['planId'], ps.pPlanList[0]['dayList'][dayIndex]['planList'][planIndex]['dayAfterStart']);
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
              ),
              const SizedBox(
                height: 200,
              )
            ],
          ),)
        ),
      ),
    );
  }
}
