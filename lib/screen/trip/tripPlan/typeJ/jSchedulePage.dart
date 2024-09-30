import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/register/termsForm.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/addPlan/addFlight.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/addPlan/searchFlight.dart';
import 'package:tripStory/util/color.dart';
import '../../../../component/button.dart';
import '../../../../util/font.dart';
import '../../../../util/tooltip_shape.dart';
import 'addPlan/addPlanPage.dart';
import 'addPlan/flight_view.dart';


class JSchedulePage extends StatefulWidget {
  const JSchedulePage({super.key});

  @override
  State<JSchedulePage> createState() => _JSchedulePageState();
}

class _JSchedulePageState extends State<JSchedulePage> {
  final js = Get.put(JPlanState());
  int selectIdx = 0;
  String startTime = '2024-08-01';
  String endTime = '2024-08-30';
  int totalDateLength = 0;
  ScrollController scrollController = ScrollController();
  Set<Marker> _markers = {};
  bool isSorting = false;

  bool testCheck = false;
  bool testCheck2 = true;
  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      diffDate();
    });
    super.initState();
  }
  void diffDate(){
    // 날짜 형식 파서
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime startDate = dateFormat.parse(startTime);
    DateTime endDate = dateFormat.parse(endTime);
    // 날짜 사이의 차이 계산
    totalDateLength = endDate.difference(startDate).inDays + 1;
    setState(() {});
    print('?? ${totalDateLength}');
  }
// 스크롤을 특정 인덱스로 이동시키는 함수
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
      body: Column(
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
                itemCount: totalDateLength,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      selectIdx == index
                          ?  Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                            width:36,
                            height: 54,
                            decoration: BoxDecoration(
                                color: Color(0xff647AED),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 4,top: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('${DateFormat('E', 'ko').format(DateFormat('yyyy-MM-dd').parse(startTime).add(Duration(days: index)))}',style: f12whitew600,),
                                  Spacer(),
                                  Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white
                                      ),
                                      child: Center(child: Text('${DateFormat('d').format(DateFormat('yyyy-MM-dd').parse(startTime).add(Duration(days: index)))}',style: f14gray800w700,)))
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                          :  GestureDetector(
                            onTap:(){
                             selectIdx = index;
                             scrollToIndex(index);
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
                                    Text('${DateFormat('E', 'ko').format(DateFormat('yyyy-MM-dd').parse(startTime).add(Duration(days: index)))}',style: f12gray300w600,),
                                    Spacer(),
                                    Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: gray300
                                        ),
                                        child: Center(child: Text('${DateFormat('d').format(DateFormat('yyyy-MM-dd').parse(startTime).add(Duration(days: index)))}',style: f14Whitew700,)))
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
          Obx(()=>Container(
            width: Get.width,
            height: js.isGoogleExpanded.value?154:0,
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
          )),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              js.isGoogleExpanded.value = !js.isGoogleExpanded.value;
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
                  padding: const EdgeInsets.symmetric(vertical: 6),
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
          Obx(()=>Expanded(
            child: Container(
              color: gray50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        js.isSorting.value = !js.isSorting.value;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: pastelBlue, // #67E299 색상
                                  width: 1.5, // 1.5px 두께
                                ),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical:2,horizontal: 10),
                              child: Text('Day ${selectIdx+1}',style: f12blueW700,),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                              onTap: (){
                                Get.to(()=>FlightView());
                              },
                              child: SvgPicture.asset('assets/icon/plane.svg', colorFilter: ColorFilter.mode(pastelBlue,BlendMode.srcIn),)),
                          const SizedBox(width: 8,),
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>SearchFlight());
                              },
                            child: SvgPicture.asset('assets/icon/plane.svg')),
                          const SizedBox(width: 8,),
                          SvgPicture.asset('assets/icon/change.svg',colorFilter:
                          ColorFilter.mode(
                            js.isSorting.value?gray600:gray400, // 원하는 색상으로 변경
                            BlendMode.srcIn, // 색상을 적용하는 블렌드 모드
                          ),),
                          // const SizedBox(width: 4,),
                          // Text('순서변경',style: js.isSorting.value?f12Gray600w500:f12Gray400w500,)
                        ],
                      ),
                    ),
                    const SizedBox(height: 9),
                    Expanded(
                      child: ReorderableListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        buildDefaultDragHandles: false,
                        itemBuilder: (context,index) {
                          return Column(
                            key: Key('$index'),
                            children: [
                              ReorderableDragStartListener(
                                index:index,
                                enabled: js.isSorting.value?true:false,
                                child: Container(
                                  width:Get.width,
                                  child: Row(
                                    children: [
                                      js.isSorting.value
                                          ? Row(
                                            children: [
                                              changeJButton(value: testCheck,onPressed: (){
                                                testCheck = !testCheck;
                                                setState(() {});
                                              }
                                              ),
                                              const SizedBox(width: 8,)
                                            ],
                                           )
                                          : const SizedBox(),
                                      Container(
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
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 13.5,vertical: 16),
                                            child: Text('07:20',style: f12Gray800w500,),
                                          )),
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
                                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 14),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                PopupMenuButton(
                                                  offset: Offset(-34, 35),
                                                  shape: const TooltipShape(borderColor:pastelBlue,borderWidth: 1),
                                                  child: SvgPicture.asset('assets/icon/memo.svg'),
                                                  color: Colors.white,
                                                  itemBuilder: (_) => <PopupMenuEntry>[
                                                    PopupMenuItem(
                                                        enabled: false,
                                                        padding:EdgeInsets.only(left: 10),
                                                        child: Text('31231ㅇㄴㅁㅇㅁㄴㅇㅁㅇㅁㅇㅁㄴㅇㄴㅁㅇㅁㄴdasdasdasdasdasdasdasdasdasdasda',style: f12mainw600(pastelBlue))
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 4,),
                                                Text('항공편 KE371 도쿄행 인천 출발',style: f12Gray800w500,),
                                                Spacer(),
                                                SvgPicture.asset('assets/icon/columnEllipsis.svg')
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
          ))
        ],
      ),
        floatingActionButton: PlusFloatingButton(
          backgroundColor: gray900,
          onPressed: ()  {
            Get.to(()=>AddPlanPage());
          },)
    );
  }
}

