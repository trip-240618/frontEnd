import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/dialog/loading.dart';
import 'package:tripStory/component/textForm/termsForm.dart';
import 'package:tripStory/component/toast/toast.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/addPlan/searchFlight.dart';
import 'package:tripStory/util/color.dart';
import '../../../../app/api/flightApi.dart';
import '../../../../app/config/dio_client.dart';
import '../../../../component/button/plusFloating.dart';
import '../../../../component/dialog/dialog.dart';
import '../../../../controller/socketState.dart';
import '../../../../util/font.dart';
import '../../../../util/tooltip_shape.dart';
import 'addPlan/addPlanPage.dart';
import 'edit_plan_page.dart';
class JSchedulePage extends StatefulWidget {
  const JSchedulePage({super.key});

  @override
  State<JSchedulePage> createState() => _JSchedulePageState();
}

class _JSchedulePageState extends State<JSchedulePage> {
  final apiFlightClient = ApiFlightClient(DioClient());
  final js = Get.put(JPlanState());
  final ts = Get.put(TripState());
  final us = Get.put(UserState());
  final socket = Get.put(SocketState());

  ScrollController scrollController = ScrollController();
  bool isSorting = false;
  bool testCheck = false;
  bool testCheck2 = true;
  FToast? fToast;
  Future _mapFuture = Future.delayed(Duration(milliseconds: 700), () => true);
  @override
  void initState() {
    fToast = FToast();
    fToast?.init(context);
    Future.delayed(Duration.zero,()async{
      js.selectedIdx.value = 0;
      js.selectedDate.value = '${DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: 0))}';
      await js.getJPlanList(1, false);
      js.jplnaMarkerSet();
      await js.getFlightList();
    });
    super.initState();
  }

/// 스크롤을 특정 인덱스로 이동시키는 함수
  void scrollToIndex(int index) {
    double itemWidth = 36 + 12;
    double scrollOffset = itemWidth * index;
    scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              height: 54,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: DateTime.parse(ts.selectTripList[0]['endDate']).difference(DateTime.parse(ts.selectTripList[0]['startDate'])).inDays + 1,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      js.selectedIdx.value == index
                          ?  Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width:36,
                            height: 54,
                            decoration: BoxDecoration(
                                color: Color(ts.selectTripList[0]['labelColor']),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 4,top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('${DateFormat('E', 'ko').format(DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: index)))}',style: f12whitew600,),
                                  Spacer(),
                                  Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white
                                      ),
                                      child: Center(child: Text('${DateFormat('d').format(DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: index)))}',style: f14gray800w700,)))
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                          :  GestureDetector(
                            onTap:()async{

                                js.selectedIdx.value = index;
                                scrollToIndex(index);
                                js.selectedDate.value = '${DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: index))}';
                                await js.getJPlanList(index+1, false);
                                js.jplnaMarkerSet();
                                setState(() {});
                            },
                            child: Container(
                              width:36,
                              height: 54,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 4,top: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('${DateFormat('E', 'ko').format(DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: index)))}',style: f12gray300w600,),
                                    Spacer(),
                                    Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: gray300
                                        ),
                                        child: Center(child: Text('${DateFormat('d').format(DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: index)))}',style: f14Whitew700,)))
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
          const SizedBox(height: 15),
        Container(
          width: Get.width,
          height: js.isGoogleExpanded.value ? 300 : 154,
          child: us.mapFirstLoading.value
              ? GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(js.latitude.value, js.longitude.value),
              zoom: 14.4746,
            ),
            polylines: js.polyline,
            markers: js.markers.toSet(),
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              if (!js.mapController.isCompleted) {
                js.mapController.complete(controller);
              }
            },
          )
              : FutureBuilder(
                future: _mapFuture,
                builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                us.mapFirstLoading.value = true;
              });
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(js.latitude.value, js.longitude.value),
                  zoom: 14.4746,
                ),
                polylines: Set<Polyline>.of(js.polyline),
                markers: js.markers.toSet(),
                myLocationButtonEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  if (!js.mapController.isCompleted) {
                    js.mapController.complete(controller);
                  }
                },
              );
            },
          ),
        ),
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragUpdate: (details) {
                if (details.delta.dy < 0) {
                  js.isGoogleExpanded.value = false;
                } else if (details.delta.dy > 0) {
                  js.isGoogleExpanded.value = true;
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(color: gray200),
                        bottom: BorderSide(color: gray200)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                      child: Container(
                        width: 54,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: gray400,
                        ),)),
                ),
              )
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(ts.selectTripList[0]['labelColor']),
                                width: 1.5, // 1.5px 두께
                              ),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical:2,horizontal: 10),
                            child: Text('Day ${js.selectedIdx.value+1}',style: f12mainw700(Color(ts.selectTripList[0]['labelColor'])),),
                          ),
                        ),
                        Spacer(),
                        js.flightList.isEmpty?
                        GestureDetector(
                            onTap: (){
                              Get.to(()=>SearchFlight());
                            },
                            child: SvgPicture.asset('assets/icon/plane.svg'))
                            : GestureDetector(
                            onTap: () async {
                              FlightDialog(context, (){});
                              //Get.to(()=>FlightView());
                            },
                            child: SvgPicture.asset('assets/icon/plane.svg', colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn),)),
                        const SizedBox(width: 8,),
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: ()async{
                            await socket.addEditor(js.jPlanList[0]['dayAfterStart']);
                            await Future.delayed(const Duration(milliseconds: 100));
                            /// 누가 편집중일 때
                            if(js.jPlanList[0]['waitList'].length!=0){
                              showCustomToast(context, fToast!, '${js.jPlanList[0]['waitList']['nickname']} 님이 일정을 수정 중입니다');
                            }else{
                              /// 편집 권한 체크 눌렀을 때
                              if(js.jPlanList[0]['checked']){
                                js.isSorting.value = true;
                                showCustomToast(context, fToast!, '변경하고 싶은 일정을 선택해 주세요');
                                js.jPlanList[0]['checked'] = false;
                                js.editPlanJList.value = jsonDecode(jsonEncode(js.jPlanList));
                              }
                              /// 편집 권한 해제 했을 때
                              else{
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
                                Get.back();
                                js.firstSwapList.value = {};
                              }
                            }
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            child: SvgPicture.asset('assets/icon/swap.svg',fit: BoxFit.none,colorFilter: ColorFilter.mode(
                              js.isSorting.value?gray600:gray400, // 원하는 색상으로 변경
                              BlendMode.srcIn, // 색상을 적용하는 블렌드 모드
                            ),),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Expanded(
                      child: js.jPlanList.isEmpty?const SizedBox():js.isSorting.value
                          ? ListView.builder(
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
                                                          js.editPlanJList[0]['planList'][index]['memo']!=''?PopupMenuButton(
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
                                                          ):const SizedBox(),
                                                          const SizedBox(width: 4,),
                                                          Expanded(child: Text('${js.editPlanJList[0]['planList'][index]['title']}',style: f12Gray800w500,overflow: TextOverflow.ellipsis,)),
                                                          PopupMenuButton<int>(
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(4),
                                                            ),
                                                            offset: const Offset(-20, 40),
                                                            padding: EdgeInsets.zero,
                                                            constraints: BoxConstraints(maxWidth: 125),
                                                            menuPadding: EdgeInsets.zero,
                                                            shadowColor: Colors.black.withOpacity(0.4),
                                                            icon: SvgPicture.asset('assets/icon/columnEllipsis.svg',fit: BoxFit.none,),
                                                            color: gray50,
                                                            itemBuilder: (context) => <PopupMenuEntry<int>>[
                                                              PopupMenuItem<int>(
                                                                onTap: (){
                                                                  js.selectJplan.value = js.editPlanJList[0]['planList'][index];
                                                                  Get.to(()=>EditPlanPage());
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
                                                                onTap: (){
                                                                  js.deleteJPlanList(js.editPlanJList[0]['planList'][index]['planId'],js.editPlanJList[0]['dayAfterStart']);
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
                                                          )
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
                          : ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: js.jPlanList[0]['planList'].length,
                            itemBuilder: (context,index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap:(){},
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
                                                  child: Center(child: Text('${js.jPlanList[0]['planList'][index]['startTime'].toString().substring(0,5)}',style: f12Gray800w500,))),
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
                                                        js.jPlanList[0]['planList'][index]['memo']!=''?PopupMenuButton(
                                                          offset: Offset(-34, 35),
                                                          shape: TooltipShape(borderColor:Color(ts.selectTripList[0]['labelColor']),borderWidth: 1),
                                                          child: SvgPicture.asset('assets/icon/memo.svg', colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn),),
                                                          color: Colors.white,
                                                          itemBuilder: (_) => <PopupMenuEntry>[
                                                            PopupMenuItem(
                                                                enabled: false,
                                                                padding:EdgeInsets.only(left: 10),
                                                                child: Text('${js.jPlanList[0]['planList'][index]['memo']}',style: f12mainw600(Color(ts.selectTripList[0]['labelColor'])))
                                                            ),
                                                          ],
                                                        ):const SizedBox(),
                                                        const SizedBox(width: 4,),
                                                        Expanded(child: Text('${js.jPlanList[0]['planList'][index]['title']}',style: f12Gray800w500,overflow: TextOverflow.ellipsis,)),
                                                        PopupMenuButton<int>(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          offset: const Offset(-20, 40),
                                                          padding: EdgeInsets.zero,
                                                          constraints: BoxConstraints(maxWidth: 125),
                                                          menuPadding: EdgeInsets.zero,
                                                          shadowColor: Colors.black.withOpacity(0.4),
                                                          icon: SvgPicture.asset('assets/icon/columnEllipsis.svg',fit: BoxFit.none,),
                                                          color: gray50,
                                                          itemBuilder: (context) => <PopupMenuEntry<int>>[
                                                            PopupMenuItem<int>(
                                                              onTap: (){
                                                                js.selectJplan.value = js.jPlanList[0]['planList'][index];
                                                                Get.to(()=>EditPlanPage());
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
                                                              onTap: (){
                                                                js.deleteJPlanList(js.jPlanList[0]['planList'][index]['planId'],js.jPlanList[0]['dayAfterStart']);
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
                                                              onTap: ()async{
                                                                showLoading(context);
                                                                Map data = {
                                                                  "planId": js.jPlanList[0]['planList'][index]['planId'],
                                                                  "dayAfterStart": js.jPlanList[0]['planList'][index]['dayAfterStart'],
                                                                  "startTime": js.jPlanList[0]['planList'][index]['startTime'],
                                                                  "title": js.jPlanList[0]['planList'][index]['title'],
                                                                  "memo": js.jPlanList[0]['planList'][index]['memo'],
                                                                  "place": js.jPlanList[0]['planList'][index]['place']==''?js.jPlanList[0]['planList'][index]['place']:'',
                                                                  "latitude":js.jPlanList[0]['planList'][index]['place']==''?js.jPlanList[0]['planList'][index]['latitude']:'',
                                                                  "longitude": js.jPlanList[0]['planList'][index]['place']==''?js.jPlanList[0]['planList'][index]['longitude']:'',
                                                                  "locker": true
                                                                };
                                                                await js.editJPlanList(data);
                                                                Get.back();
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
                                                        )
                                                        // SvgPicture.asset('assets/icon/columnEllipsis.svg')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                      // Container(
                                      //     width:58,
                                      //     height:50,
                                      //     decoration: BoxDecoration(
                                      //       color: gray200,
                                      //       border: Border.all(color: gray200),
                                      //       borderRadius: BorderRadius.only(
                                      //         topLeft: Radius.circular(4),    // 좌측 상단 반경 4px
                                      //         topRight: Radius.circular(0),   // 우측 상단 반경 0px
                                      //         bottomRight: Radius.circular(0),// 우측 하단 반경 0px
                                      //         bottomLeft: Radius.circular(4), // 좌측 하단 반경 4px
                                      //       ),
                                      //     ),
                                      //     child: Center(child: Text('${js.jPlanList[0]['planList'][index]['startTime'].toString().substring(0,5)}',style: f12Gray800w500,))),
                                      // Expanded(
                                      //   child: Container(
                                      //     decoration: BoxDecoration(
                                      //       color: Colors.white,
                                      //       border: Border.all(color: gray200),
                                      //       borderRadius: BorderRadius.only(
                                      //         topLeft: Radius.circular(0),    // 좌측 상단 반경 4px
                                      //         topRight: Radius.circular(4),   // 우측 상단 반경 0px
                                      //         bottomRight: Radius.circular(4),// 우측 하단 반경 0px
                                      //         bottomLeft: Radius.circular(0), // 좌측 하단 반경 4px
                                      //       ),
                                      //     ),
                                      //     child: Padding(
                                      //       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 14),
                                      //       child: Row(
                                      //         crossAxisAlignment: CrossAxisAlignment.center,
                                      //         children: [
                                      //           js.jPlanList[0]['planList'][index]['memo']!=''?PopupMenuButton(
                                      //             offset: Offset(-34, 35),
                                      //             shape: TooltipShape(borderColor:Color(ts.selectTripList[0]['labelColor']),borderWidth: 1),
                                      //             child: SvgPicture.asset('assets/icon/memo.svg', colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn),),
                                      //             color: Colors.white,
                                      //             itemBuilder: (_) => <PopupMenuEntry>[
                                      //               PopupMenuItem(
                                      //                   enabled: false,
                                      //                   padding:EdgeInsets.only(left: 10),
                                      //                   child: Text('${js.jPlanList[0]['planList'][index]['memo']}',style: f12mainw600(Color(ts.selectTripList[0]['labelColor'])))
                                      //               ),
                                      //             ],
                                      //           ):const SizedBox(),
                                      //           const SizedBox(width: 4,),
                                      //           Text('${js.jPlanList[0]['planList'][index]['title']}',style: f12Gray800w500,),
                                      //           Spacer(),
                                      //           SvgPicture.asset('assets/icon/columnEllipsis.svg')
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  const SizedBox(height: 4)
                                ],
                              );
                            },
                          ),
                        ),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          )
        ],
      )),
        floatingActionButton: PlusFloatingButton(
          backgroundColor: gray900,
          onPressed: ()  {
            Get.to(()=>AddPlanPage());
          },)
    );
  }
}

