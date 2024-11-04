import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/screen/trip/locker/planB/add_planB_j.dart';
import 'package:tripStory/screen/trip/locker/planB/edit_planB_j.dart';
import '../../../../component/button/plusFloating.dart';
import '../../../../component/dialog/daySelect.dart';
import '../../../../util/color.dart';
import '../../../../util/font.dart';
import '../../../../util/tooltip_shape.dart';

class JPlanB extends StatefulWidget {
  const JPlanB({super.key});

  @override
  State<JPlanB> createState() => _JPlanBState();
}

class _JPlanBState extends State<JPlanB> {
  final js = Get.put(JPlanState());
  final ts = Get.put(TripState());
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await js.getPlanBJList();
      isLoading = false;
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Obx(()=>Container(
              child: ListView.builder(
                itemCount: js.planBJList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // 부모와 충돌 방지
                itemBuilder: (context, dayIndex) {
                  return Column(
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          child: Row(
                            children: [
                              js.planBJList[dayIndex]['dayAfterStart']!=-1?
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color(ts.selectTripList[0]['labelColor']), width: 1.5),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 12),
                                  child: Text('Day ${js.planBJList[dayIndex]['dayAfterStart']}', style: f12mainw700(Color(ts.selectTripList[0]['labelColor']),),),
                                ),
                              ):
                              Text('날짜 미정', style: f14Gray800w500,),
                              const SizedBox(
                                width: 6,
                              ),
                              js.planBJList[dayIndex]['dayAfterStart']!=-1?Text('${DateFormat('M.d (E)', 'ko').format(DateTime.parse(ts.selectTripList[0]['startDate']).add(Duration(days: js.planBJList[dayIndex]['dayAfterStart']-1)))}', style: f14Gray800w500,):SizedBox(),
                              Spacer(),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color(ts.selectTripList[0]['labelColor']),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(child: Text('${js.planBJList[dayIndex]['planList'].length}', style: f12Whitew700,)),
                              ),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                onTap: () {
                                  js.planBJList[dayIndex]['checked'] = !js.planBJList[dayIndex]['checked'];
                                  js.planBJList.refresh();
                                },
                                child: SvgPicture.asset(
                                    js.planBJList[dayIndex]['checked']?
                                    'assets/icon/caretDown.svg':'assets/icon/caretUp.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedSize(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeOutBack,
                              child: js.planBJList[dayIndex]['checked']==true?Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  color: gray50,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: js.planBJList[dayIndex]['planList'].length,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (context, planIndex){
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 20, right: 20,bottom: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        width:58,
                                                        height:50,
                                                        decoration: BoxDecoration(
                                                          color: gray200,
                                                          border: Border.all(color: gray200),
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(4),    // 좌측 상단 반경 4px
                                                            topRight: Radius.circular(0),   // 우측 상단 반경 0px
                                                            bottomRight: Radius.circular(0),// 우측 하단 반경 0px
                                                            bottomLeft: Radius.circular(4), // 좌측 하단 반경 4px
                                                          ),
                                                        ),
                                                        child: Center(child: Text('${js.planBJList[dayIndex]['planList'][planIndex]['startTime'].toString().substring(0,5)}',style: f12Gray800w500,))),
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(color: gray200),
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(0),    // 좌측 상단 반경 4px
                                                            topRight: Radius.circular(4),   // 우측 상단 반경 0px
                                                            bottomRight: Radius.circular(4),// 우측 하단 반경 0px
                                                            bottomLeft: Radius.circular(0), // 좌측 하단 반경 4px
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              js.planBJList[dayIndex]['planList'][planIndex]['memo']!=''?PopupMenuButton(
                                                                offset: Offset(-34, -20),
                                                                shape: TooltipShape(borderColor:Color(ts.selectTripList[0]['labelColor']),borderWidth: 1),
                                                                child: SvgPicture.asset('assets/icon/memo.svg', colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn),),
                                                                color: Colors.white,
                                                                itemBuilder: (_) => <PopupMenuEntry>[
                                                                  PopupMenuItem(
                                                                      enabled: false,
                                                                      padding:EdgeInsets.only(left: 10),
                                                                      child: Text('${js.planBJList[dayIndex]['planList'][planIndex]['memo']}',style: f12mainw600(Color(ts.selectTripList[0]['labelColor'])))
                                                                  ),
                                                                ],
                                                              ):const SizedBox(),
                                                              const SizedBox(width: 4,),
                                                              Expanded(child: Text('${js.planBJList[dayIndex]['planList'][planIndex]['title']}',style: f12Gray800w500,overflow: TextOverflow.ellipsis,)),
                                                              PopupMenuButton<int>(
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(4),
                                                                ),
                                                                offset: const Offset(-33, 40),
                                                                padding: EdgeInsets.zero,
                                                                constraints: BoxConstraints(maxWidth: 125),
                                                                menuPadding: EdgeInsets.zero,
                                                                shadowColor: Colors.black.withOpacity(0.4),
                                                                icon: SvgPicture.asset('assets/icon/columnEllipsis.svg',fit: BoxFit.none,),
                                                                color: gray50,
                                                                itemBuilder: (context) => <PopupMenuEntry<int>>[
                                                                  PopupMenuItem<int>(
                                                                    onTap: (){
                                                                      js.selectPlanBJList.value = js.planBJList[dayIndex]['planList'][planIndex];
                                                                      Get.to(()=>EditPlanBJ());
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
                                                                      print('start??${js.planBJList[dayIndex]['dayAfterStart']}');
                                                                      await js.deletePlanBJList(js.planBJList[dayIndex]['planList'][planIndex]['planId'], js.planBJList[dayIndex]['dayAfterStart']);
                                                                      await js.getPlanBJList();
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
                                                                      js.selectPlanBJList.value = js.planBJList[dayIndex]['planList'][planIndex];
                                                                      js.planBSelectedDate.value = ts.selectTripList[0]['startDate'];
                                                                      js.selectPlanBJList['locker'] = false;
                                                                      js.selectPlanBJList['dayAfterStart'] == -1?ButtonSelectDayBottomSheet(context,'일정이동시 날짜 지정이 필요해요','일정 이동')
                                                                      :await js.editJPlanList(js.selectPlanBJList.value);
                                                                      await js.getPlanBJList();
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
                                                                              'assets/bottomNavi/schedule.svg',
                                                                              fit: BoxFit.none,
                                                                              colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(width: 10),
                                                                          Text(
                                                                            '일정 이동',
                                                                            style: f14Gray800w500,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                              // SvgPicture.asset('assets/icon/columnEllipsis.svg')
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              )
                                  : const SizedBox(height: 16,)
                          )





                        ],
                      )
                    ],
                  );
                },
              ),
            ),),

          ],
        ),
      ),
        floatingActionButton: PlusFloatingButton(
          backgroundColor: gray900,
          onPressed: ()  {
            Get.to(()=>AddPlanBJ());
          },)
    );
  }
}
