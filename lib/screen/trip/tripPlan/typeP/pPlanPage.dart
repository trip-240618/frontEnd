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
import '../../../../component/textForm/textform.dart';
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
  bool isLoading = true;
  FocusNode _focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  bool isEdit = false; /// 추가, 수정중인지 여부
  /// Text Con
  TextEditingController _controller = TextEditingController();
  int selectWeek = 0;
  int selectDayIdx = 0;
  FToast? fToast;
  @override
  void initState() {
    fToast = FToast();
    fToast?.init(context);
    ps.totalDays.value = DateTime.parse(ts.selectTripList[0]['endDate']).difference(DateTime.parse(ts.selectTripList[0]['startDate'])).inDays+1;
    Future.delayed(Duration.zero,()async{
      await ps.getPPlanList(false);
      print('ppp${ps.pPlanList}');
      isLoading = false;
      setState(() {

      });
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
      child: isLoading?SizedBox():Scaffold(
        backgroundColor: gray50,
        resizeToAvoidBottomInset: false, //포커스시 바텀시트 안올라옴
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Obx(()=>Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 16,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white
                ),

              ),
              Container(
                      color: gray50,
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Row(
                          children: [
                            ps.totalDays.value <=7
                                ? const SizedBox()
                                : Row(
                                    children: [
                                      ps.selectedWeekIdx.value > 1 ?
                                      InkWell(
                                        borderRadius: BorderRadius.circular(100),
                                        onTap: () async{
                                          if(ps.selectedWeekIdx.value>1){
                                            ps.selectedWeekIdx.value --;
                                            await ps.getPPlanList(false);
                                          }
                                        },
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          child: SvgPicture.asset('assets/icon/leftCaret.svg', fit: BoxFit.none,),
                                        ),
                                      ) : const SizedBox(width: 12),
                                      const SizedBox(width: 4,),
                                      Text('WEEK ${ps.pPlanList[0]['week']}', style: f14mainw600(Color(ts.selectTripList[0]['labelColor']),)),
                                      const SizedBox(width: 4,),
                                      ps.totalDays.value-(ps.selectedWeekIdx.value*7)>0 ?
                                      InkWell(
                                        borderRadius: BorderRadius.circular(100),
                                        onTap: () async{
                                          if(ps.totalDays.value-(ps.selectedWeekIdx.value*7)>0){
                                            ps.selectedWeekIdx.value ++;
                                            await ps.getPPlanList(false);
                                          }
                                        },
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          child: SvgPicture.asset('assets/icon/rightCaret.svg', fit: BoxFit.none,),
                                        ),
                                      ):const SizedBox(),
                                    ],),
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
                                    ps.isSorting.refresh();
                                    Get.back();
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
                    ps.ReorderPPlanList[0]['dayList'][newIndex]['data']['orderByDate'] = -1;
                    ps.ReorderPPlanList[0]['dayList'][newIndex]['data']['dayAfterStart'] =
                    ps.ReorderPPlanList[0]['dayList'][newIndex-1]['type'] == 'day'? ps.ReorderPPlanList[0]['dayList'][newIndex-1]['data']:ps.ReorderPPlanList[0]['dayList'][newIndex-1]['data']['dayAfterStart'];
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
                                        _controller.clear();
                                        isEdit = true;
                                        TextFormSheet(context, '여행일정을 입력해주세요',_controller, _focusNode, () async {
                                          removeLastPlan();
                                          Map data = {
                                            "content":'${_controller.text}',
                                            "dayAfterStart": ps.pPlanList[0]['dayList'][selectDayIdx]['dayAfterStart'],
                                            "locker": false
                                          };
                                          await ps.addPPlanList(data);
                                          isEdit = false;

                                        });
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
                                              height: 25,
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
                                                icon: SvgPicture.asset('assets/icon/rowEllipsis.svg',fit: BoxFit.none,),
                                                color: gray50,
                                                itemBuilder: (context) => <PopupMenuEntry<int>>[
                                                  PopupMenuItem<int>(
                                                    onTap: (){
                                                      ps.selectPPlan.value = ps.pPlanList[0]['dayList'][dayIndex]['planList'][planIndex];
                                                      _controller.text =  ps.selectPPlan['content'];
                                                      isEdit = true;
                                                      TextFormSheet(context, '여행일정을 입력해주세요',_controller, _focusNode, () async {
                                                        if(_controller.text != ''){
                                                          ps.selectPPlan['content'] = _controller.text;
                                                          await ps.editPPlanList(ps.selectPPlan.value);
                                                        }
                                                        isEdit = false;
                                                      });
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
                                                    onTap: () async {
                                                      ps.selectPPlan.value = ps.pPlanList[0]['dayList'][dayIndex]['planList'][planIndex];
                                                      ps.selectPPlan['locker'] = true;
                                                      ps.selectPPlan['dayAfterStart'] = 0;
                                                      await ps.lockerMovePPlanList(ps.selectPPlan.value);
                                                    },
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
