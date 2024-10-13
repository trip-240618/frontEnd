import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/register/termsForm.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/addPlan/searchFlight.dart';
import 'package:tripStory/util/color.dart';
import '../../../../app/api/flightApi.dart';
import '../../../../app/config/dio_client.dart';
import '../../../../component/button.dart';
import '../../../../component/dialog/dialog.dart';
import '../../../../controller/socketState.dart';
import '../../../../util/font.dart';
import '../../../../util/tooltip_shape.dart';
import 'addPlan/addPlanPage.dart';


class JSchedulePage extends StatefulWidget {
  const JSchedulePage({super.key});

  @override
  State<JSchedulePage> createState() => _JSchedulePageState();
}

class _JSchedulePageState extends State<JSchedulePage> {
  final apiFlightClient = ApiFlightClient(DioClient());
  final js = Get.put(JPlanState());
  final ts = Get.put(TripState());
  final socket = Get.put(SocketState());
  // int selectIdx = 0;
  ScrollController scrollController = ScrollController();
  Set<Marker> _markers = {};
  bool isSorting = false;
  bool testCheck = false;
  bool testCheck2 = true;

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      js.selectedIdx.value = 0;
      js.selectedDate.value = '${DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: 0))}';
      js.getJPlanList(1, false);
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
                        onTap:(){
                          js.selectedIdx.value = index;
                          scrollToIndex(index);
                          js.selectedDate.value = '${DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: index))}';
                          js.getJPlanList(index+1, false);
                          print('?? 선택된 날짜 ${js.selectedIdx.value}');
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
            height: js.isGoogleExpanded.value?300:154,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(js.latitude.value, js.longitude.value),
                zoom: 14.4746,
              ),
              markers: _markers.toSet(),
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                if (!js.mapController.isCompleted) {
                  js.mapController.complete(controller);
                }
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
                        GestureDetector(
                          onTap: (){
                            socket.addEditor(1);
                            js.isSorting.value = !js.isSorting.value;
                          },
                          child: SvgPicture.asset('assets/icon/change.svg',colorFilter:
                          ColorFilter.mode(
                            js.isSorting.value?gray600:gray400, // 원하는 색상으로 변경
                            BlendMode.srcIn, // 색상을 적용하는 블렌드 모드
                          ),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Expanded(
                      child: js.jPlanList.isEmpty?const SizedBox():ReorderableListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: js.jPlanList[0]['planList'].length,
                        buildDefaultDragHandles: false,
                        itemBuilder: (context,index) {
                          return Column(
                            key: Key('$index'),
                            children: [
                              ReorderableDragStartListener(
                                index:index,
                                enabled: false,
                                child: Row(
                                  children: [
                                    js.isSorting.value
                                        ? changeJButton(
                                        value: js.jPlanList[0]['planList'][index]['checked'],
                                        onPressed: (){
                                          js.jPlanList[0]['planList'] = js.jPlanList[0]['planList'].asMap().map((i, plan) {
                                            return MapEntry(i, {
                                              ...plan,
                                              'checked': i == index ? true : false,
                                            });
                                          }).values.toList();
                                          js.jPlanList.refresh();
                                        }
                                        )
                                        : const SizedBox(),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: gray900),
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

                                                              Get.back();
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
                              ),
                              const SizedBox(height: 4)
                            ],
                          );
                        },
                        onReorder: (int oldIndex, int newIndex) {
                          // setState(() {
                          //   if(oldIndex<newIndex){
                          //     newIndex -= 1;
                          //   }
                          //   changed = false;
                          //   var element = list.removeAt(oldIndex);
                          //   list.insert(newIndex,element);
                          //   changeIndex(oldIndex, newIndex);
                          // });
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
        // floatingActionButton: PlusFloatingButton(
        //   backgroundColor: gray900,
        //   onPressed: ()  {
        //     Get.to(()=>AddPlanPage());
        //   },)
    );
  }
}

