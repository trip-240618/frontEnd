import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import '../../../../component/appbar.dart';
import '../../../../component/bottomContainer.dart';
import '../../../../component/dialog/loading.dart';
import '../../../../component/toast/toast.dart';
import '../../../../controller/jPlanState.dart';
import '../../../../controller/tripState.dart';
import '../../../../util/color.dart';
import '../../../../util/font.dart';
import '../../../../util/tooltip_shape.dart';

class JplanSwapPage extends StatefulWidget {
  const JplanSwapPage({super.key});

  @override
  State<JplanSwapPage> createState() => _JplanSwapPageState();
}

class _JplanSwapPageState extends State<JplanSwapPage> {
  final js = Get.find<JPlanState>();
  final ts = Get.find<TripState>();
  FToast? fToast;
  @override
  void initState() {
    fToast = FToast();
    fToast?.init(context);
    super.initState();
  }

  Future<bool> _handleWillPop(BuildContext context) async {
    if (Platform.isAndroid) {
      showConfirmCancelTapDialog(context, '순서 변경을 종료하시겠습니까?','확인', null, ()async{
        js.jPlanList[0]['checked'] = true;
        js.isSorting.value = false;
        js.deleteSwapJPlan(js.editPlanJList[0]['dayAfterStart']);
        js.firstSwapList.value = {};
        Get.back();
        Get.back();
      });
      return false;
    }
    return false; // iOS는 뒤로가기 방지
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _handleWillPop(context),
      child: Scaffold(
        appBar: BackAppBar(
          text: '', onTap: (){
          showConfirmCancelTapDialog(context, '순서 변경을 종료하시겠습니까?','확인', null, ()async{
              js.jPlanList[0]['checked'] = true;
              js.isSorting.value = false;
              js.deleteSwapJPlan(js.editPlanJList[0]['dayAfterStart']);
              js.firstSwapList.value = {};
              Get.back();
              Get.back();
            });
        }, color: Colors.white,),
        body: Obx(()=>Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('일정 선택 후 다른 일정과',style: f20gray900w700,),
              Text('시간 순서를 바꿀 수 있어요',style: f20gray900w700,),
              const SizedBox(height: 66,),
              Expanded(
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: js.editPlanJList[0]['planList'].length,
                    itemBuilder: (context,index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap:(){
                                    /// 이미 선택된 날짜 한번더 클릭
                                    if(js.editPlanJList[0]['planList'][index]['planId']==js.firstSwapList['planId']){
                                      js.firstSwapList.value = {};
                                      js.editPlanJList.refresh();
                                    }
                                    /// 선택된 리스트 스왑
                                    else if(js.firstSwapList.isNotEmpty&&js.editPlanJList[0]['planList'][index]['planId']!=js.firstSwapList['planId']){
                                      int swapIndex = js.editPlanJList[0]['planList'].indexWhere((item) => item['planId'] == js.firstSwapList['planId']);

                                      var temp = js.editPlanJList[0]['planList'][index];
                                      js.editPlanJList[0]['planList'][index] = js.editPlanJList[0]['planList'][swapIndex];
                                      js.editPlanJList[0]['planList'][swapIndex] = temp;

                                      var tempStartTime = js.editPlanJList[0]['planList'][index]['startTime'];
                                      js.editPlanJList[0]['planList'][index]['startTime'] = js.editPlanJList[0]['planList'][swapIndex]['startTime'];
                                      js.editPlanJList[0]['planList'][swapIndex]['startTime'] = tempStartTime;

                                      var newOrderByDate = js.editPlanJList[0]['planList'][index]['orderByDate'];
                                      js.editPlanJList[0]['planList'][index]['orderByDate'] = js.editPlanJList[0]['planList'][swapIndex]['orderByDate'];
                                      js.editPlanJList[0]['planList'][swapIndex]['orderByDate'] = newOrderByDate;

                                      js.editPlanJList.refresh();
                                      js.firstSwapList.value = {};
                                      js.firstSwapList.refresh();
                                    }
                                    /// 처음에 한번 선택
                                    else{
                                      js.firstSwapList.value = js.editPlanJList[0]['planList'][index];
                                      js.editPlanJList.refresh();
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: js.editPlanJList[0]['planList'][index]['planId']==js.firstSwapList['planId']?Border.all(color: gray900):null,
                                        borderRadius: BorderRadius.circular(4)
                                    ),
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
                                            child: Center(child: Text('${js.editPlanJList[0]['planList'][index]['startTime'].toString().substring(0,5)}',style: f12Gray800w500,))),
                                        Expanded(
                                          child: Container(
                                            height: 50,
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
                                                  js.editPlanJList[0]['planList'][index]['memo']!=''
                                                      ?PopupMenuButton(
                                                    offset: Offset(-34, 35),
                                                    shape: TooltipShape(borderColor:Color(ts.selectTripList[0]['labelColor']),borderWidth: 1),
                                                    child: SvgPicture.asset('assets/icon/memo.svg', colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn),),
                                                    color: Colors.white,
                                                    itemBuilder: (_) => <PopupMenuEntry>[
                                                      PopupMenuItem(
                                                          enabled: false,
                                                          padding:EdgeInsets.only(left: 10),
                                                          child: Text('${js.editPlanJList[0]['planList'][index]['memo']}',style: f12mainw600(Color(ts.selectTripList[0]['labelColor'])))
                                                      ),
                                                    ],
                                                  )
                                                      :const SizedBox(),
                                                  const SizedBox(width: 4,),
                                                  Expanded(child: Text('${js.editPlanJList[0]['planList'][index]['title']}',style: f12Gray800w500,overflow: TextOverflow.ellipsis,)),
                                                  Container(height: 50,),
                                                  // PopupMenuButton<int>(
                                                  //   shape: RoundedRectangleBorder(
                                                  //     borderRadius: BorderRadius.circular(4),
                                                  //   ),
                                                  //   offset: const Offset(-20, 40),
                                                  //   padding: EdgeInsets.zero,
                                                  //   constraints: BoxConstraints(maxWidth: 125),
                                                  //   menuPadding: EdgeInsets.zero,
                                                  //   shadowColor: Colors.black.withOpacity(0.4),
                                                  //   icon: SvgPicture.asset('assets/icon/columnEllipsis.svg',fit: BoxFit.none,),
                                                  //   color: gray50,
                                                  //   itemBuilder: (context) => <PopupMenuEntry<int>>[
                                                  //     PopupMenuItem<int>(
                                                  //       onTap: (){
                                                  //         js.selectJplan.value = js.editPlanJList[0]['planList'][index];
                                                  //         Get.to(()=>EditPlanPage());
                                                  //       },
                                                  //       padding: EdgeInsets.zero,
                                                  //       value: 1,
                                                  //       child: Column(
                                                  //         children: [
                                                  //           Padding(
                                                  //             padding: const EdgeInsets.only(left: 12, right: 12),
                                                  //             child: Row(
                                                  //               mainAxisAlignment: MainAxisAlignment.start,
                                                  //               crossAxisAlignment: CrossAxisAlignment.center,
                                                  //               children: [
                                                  //                 SvgPicture.asset(
                                                  //                   'assets/icon/pencil.svg',
                                                  //                   colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                  //                   fit: BoxFit.none,
                                                  //                 ),
                                                  //                 const SizedBox(width: 10),
                                                  //                 Text(
                                                  //                   '일정 수정',
                                                  //                   style: f14Gray800w500,
                                                  //                 ),
                                                  //               ],
                                                  //             ),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //     const PopupMenuDivider(height: 1),
                                                  //     PopupMenuItem<int>(
                                                  //       onTap: (){
                                                  //         js.deleteJPlanList(js.editPlanJList[0]['planList'][index]['planId'],js.editPlanJList[0]['dayAfterStart']);
                                                  //       },
                                                  //       padding: EdgeInsets.zero,
                                                  //       value: 2,
                                                  //       child: Padding(
                                                  //         padding: const EdgeInsets.symmetric(horizontal: 12),
                                                  //         child: Row(
                                                  //           mainAxisAlignment: MainAxisAlignment.start,
                                                  //           crossAxisAlignment: CrossAxisAlignment.center,
                                                  //           children: [
                                                  //             Container(
                                                  //               width:24,
                                                  //               height:24,
                                                  //               child: SvgPicture.asset(
                                                  //                 'assets/icon/trashCan.svg',
                                                  //                 fit: BoxFit.none,
                                                  //                 colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                  //               ),
                                                  //             ),
                                                  //             const SizedBox(width: 10),
                                                  //             Text(
                                                  //               '일정 삭제',
                                                  //               style: f14Gray800w500,
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //     const PopupMenuDivider(height: 1),
                                                  //     PopupMenuItem<int>(
                                                  //       padding: EdgeInsets.zero,
                                                  //       value: 3,
                                                  //       child: Padding(
                                                  //         padding: const EdgeInsets.symmetric(horizontal: 12),
                                                  //         child: Row(
                                                  //           mainAxisAlignment: MainAxisAlignment.start,
                                                  //           crossAxisAlignment: CrossAxisAlignment.center,
                                                  //           children: [
                                                  //             Container(
                                                  //               width:24,
                                                  //               height:24,
                                                  //               child: SvgPicture.asset(
                                                  //                 'assets/bottomNavi/locker.svg',
                                                  //                 fit: BoxFit.none,
                                                  //                 colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                  //               ),
                                                  //             ),
                                                  //             const SizedBox(width: 10),
                                                  //             Text(
                                                  //               '보관함 이동',
                                                  //               style: f14Gray800w500,
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // )
                                                  // SvgPicture.asset('assets/icon/columnEllipsis.svg')
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4)
                        ],
                      );
                    },
                  )
              )
            ],
          ),
        )),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 42),
            child: BottomContainer(
              onTap: (){
                showConfirmCancelTapDialog(context, '일정 순서를 변경하시겠습니까?','확인', null, ()async{
                  showLoading(context);
                  js.jPlanList[0]['checked'] = true;
                  Map<String,dynamic> transMap = {
                    "dayAfterStart": js.editPlanJList[0]['dayAfterStart'],
                    'orderDtos': (js.editPlanJList[0]['planList'] as List).map((item){
                      return {
                        'planId': item['planId'],
                        'startTime': item['startTime'].substring(0,5),
                        'orderByDate': item['orderByDate']
                      };
                    }).toList()
                  };
                  await js.swapJPlan(transMap);
                  js.isSorting.value = false;
                  js.deleteSwapJPlan(js.editPlanJList[0]['dayAfterStart']);
                  js.firstSwapList.value = {};
                  Get.back();
                  Get.back();
                  Get.back();
                  showCustomToast(context, fToast!, '일정 순서 변경이 완료됐습니다.',true);
                });
              },title: '순서 변경',isBlack: true,),
          )
      ),
    );
  }
}
