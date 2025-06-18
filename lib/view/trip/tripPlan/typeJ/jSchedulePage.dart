import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/button/plusFloating.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/dialog/loading.dart';
import 'package:tripStory/component/toast/toast.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/socketState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/util/tooltip_shape.dart';
import 'package:tripStory/view/trip/tripPlan/typeJ/addPlan/addPlanPage.dart';
import 'package:tripStory/view/trip/tripPlan/typeJ/addPlan/searchFlight.dart';
import 'package:tripStory/view/trip/tripPlan/typeJ/edit_plan_page.dart';
import 'package:tripStory/view/trip/tripPlan/typeJ/jplan_swap_page.dart';

class JSchedulePage extends StatefulWidget {
  const JSchedulePage({super.key});

  @override
  State<JSchedulePage> createState() => _JSchedulePageState();
}

class _JSchedulePageState extends State<JSchedulePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // final apiFlightClient = ApiFlightClient(DioClient());
  final js = Get.find<JPlanState>();
  final ts = Get.find<TripState>();
  final us = Get.find<UserState>();
  final socket = Get.put(SocketState());
  ScrollController scrollController = ScrollController();
  FToast? fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast?.init(context);
    Future.delayed(Duration.zero, () async {
      await js.getCurrentLocation(context);
      js.selectedDate.value =
          '${DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: 0))}';
      await js.getJPlanList(1, false);
      await js.getFlightList();
      js.jPlanMarkerSet();
      if (js.jPlanList.isNotEmpty) {
        var targetPlan = js.jPlanList[0]['planList']?.firstWhere(
          (plan) => plan['latitude'] != null && plan['longitude'] != null,
          orElse: () => null,
        );
        if (targetPlan != null) {
          CameraPosition cameraPosition =
              CameraPosition(target: LatLng(targetPlan['latitude'], targetPlan['longitude']), zoom: 12);
          final GoogleMapController controller = await js.mapController.future;
          await controller.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));
        }
      }
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      js.resetState();
    });
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 54,
                    child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: DateTime.parse(ts.selectTripList[0]['endDate'])
                              .difference(DateTime.parse(ts.selectTripList[0]['startDate']))
                              .inDays +
                          1,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            js.selectedIdx.value == index
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 54,
                                        decoration: BoxDecoration(
                                            color: Color(ts.selectTripList[0]['labelColor']),
                                            borderRadius: BorderRadius.circular(100)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 4, top: 4),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${DateFormat('E', 'ko').format(DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: index)))}',
                                                style: f12whitew600,
                                              ),
                                              Spacer(),
                                              Container(
                                                  width: 28,
                                                  height: 28,
                                                  decoration:
                                                      BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                                  child: Center(
                                                      child: Text(
                                                    '${DateFormat('d').format(DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: index)))}',
                                                    style: f14gray800w700,
                                                  )))
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      js.selectedIdx.value = index;
                                      scrollToIndex(index);
                                      js.selectedDate.value =
                                          '${DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: index))}';
                                      await js.getJPlanList(index + 1, false);
                                      js.jPlanMarkerSet();
                                      if (js.jPlanList.isNotEmpty) {
                                        var targetPlan = js.jPlanList[0]['planList']?.firstWhere(
                                          (plan) => plan['latitude'] != null && plan['longitude'] != null,
                                          orElse: () => null,
                                        );
                                        if (targetPlan != null) {
                                          CameraPosition cameraPosition = CameraPosition(
                                              target: LatLng(targetPlan['latitude'], targetPlan['longitude']),
                                              zoom: 12);
                                          final GoogleMapController controller = await js.mapController.future;
                                          await controller.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));
                                        }
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 36,
                                      height: 54,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 4, top: 4),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${DateFormat('E', 'ko').format(DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: index)))}',
                                              style: f12gray300w600,
                                            ),
                                            Spacer(),
                                            Container(
                                                width: 28,
                                                height: 28,
                                                decoration: BoxDecoration(shape: BoxShape.circle, color: gray300),
                                                child: Center(
                                                    child: Text(
                                                  '${DateFormat('d').format(DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(Duration(days: index)))}',
                                                  style: f14Whitew700,
                                                )))
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
                js.latitude.value == 0.0
                    ? const SizedBox()
                    : Container(
                        width: Get.width,
                        height: js.googleMapHeight.value,
                        child: Obx(() => GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(js.latitude.value, js.longitude.value),
                                zoom: 14.4746,
                              ),
                              polylines: Set<Polyline>.of(js.polyline),
                              markers: js.markers.toSet(),
                              myLocationButtonEnabled: false,
                              myLocationEnabled: true,
                              onMapCreated: (GoogleMapController controller) {
                                if (!js.mapController.isCompleted) {
                                  js.mapController.complete(controller);
                                }
                              },
                            )),
                      ),
                GestureDetector(
                    onPanUpdate: (details) {
                      // 높이를 드래그한 만큼 변경
                      double newHeight = js.googleMapHeight.value + details.delta.dy;
                      // 높이 제한
                      if (newHeight < 154) {
                        newHeight = 154; // 최소 높이
                      } else if (newHeight > 300) {
                        newHeight = 300; // 최대 높이
                      }
                      js.googleMapHeight.value = newHeight;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(top: BorderSide(color: gray200), bottom: BorderSide(color: gray200))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                            child: Container(
                          width: 54,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: gray400,
                          ),
                        )),
                      ),
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(ts.selectTripList[0]['labelColor']),
                                      width: 1.5, // 1.5px 두께
                                    ),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                  child: Text(
                                    'Day ${js.selectedIdx.value + 1}',
                                    style: f12mainw700(Color(ts.selectTripList[0]['labelColor'])),
                                  ),
                                ),
                              ),
                              Spacer(),
                              js.flightList.isEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        Get.to(() => SearchFlight());
                                      },
                                      child: SvgPicture.asset('assets/icon/plane.svg'))
                                  : GestureDetector(
                                      onTap: () async {
                                        FlightDialog(context, () {});
                                      },
                                      child: SvgPicture.asset(
                                        'assets/icon/plane.svg',
                                        colorFilter: ColorFilter.mode(
                                            Color(ts.selectTripList[0]['labelColor']), BlendMode.srcIn),
                                      )),
                              const SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () async {
                                  if (js.jPlanList.isEmpty || js.jPlanList[0]['planList'].length == 0) {
                                    showCustomToast(context, fToast!, '순서를 변경할 일정이 없습니다', true);
                                  } else {
                                    await socket.addEditor(js.jPlanList[0]['dayAfterStart']);
                                    await Future.delayed(const Duration(milliseconds: 100));

                                    /// 누가 편집중일 때
                                    if (js.jPlanList[0]['waitList'].length != 0) {
                                      showCustomToast(context, fToast!,
                                          '${js.jPlanList[0]['waitList']['nickname']} 님이 일정을 수정 중입니다', true);
                                    } else {
                                      js.isSorting.value = true;
                                      js.jPlanList[0]['checked'] = false;
                                      js.jPlanList.refresh();
                                      js.editPlanJList.value = jsonDecode(jsonEncode(js.jPlanList));
                                      Get.to(() => JplanSwapPage());
                                    }
                                  }
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset(
                                    'assets/icon/swap.svg',
                                    fit: BoxFit.none,
                                    colorFilter: ColorFilter.mode(
                                      gray600,
                                      BlendMode.srcIn, // 색상을 적용하는 블렌드 모드
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    if (js.jPlanList.isEmpty || js.jPlanList[0]['planList'].length == 0) {
                                      showCustomToast(context, fToast!, '순서를 변경할 일정이 없습니다', true);
                                    } else {
                                      await socket.addEditor(js.jPlanList[0]['dayAfterStart']);
                                      await Future.delayed(const Duration(milliseconds: 100));

                                      /// 누가 편집중일 때
                                      if (js.jPlanList[0]['waitList'].length != 0) {
                                        showCustomToast(context, fToast!,
                                            '${js.jPlanList[0]['waitList']['nickname']} 님이 일정을 수정 중입니다', true);
                                      } else {
                                        js.isSorting.value = true;
                                        js.jPlanList[0]['checked'] = false;
                                        js.jPlanList.refresh();
                                        js.editPlanJList.value = jsonDecode(jsonEncode(js.jPlanList));
                                        Get.to(() => JplanSwapPage());
                                      }
                                    }
                                  },
                                  child: Text(
                                    '순서 변경',
                                    style: f12gray600w600,
                                  ))
                            ],
                          ),
                          const SizedBox(height: 9),
                          Expanded(
                              child: js.jPlanList.isEmpty
                                  ? const SizedBox()
                                  : ListView.builder(
                                      controller: js.listController,
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: js.jPlanList[0]['planList'].length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    behavior: HitTestBehavior.opaque,
                                                    onTap: () async {
                                                      if (js.jPlanList[0]['planList'][index]['latitude'] != null &&
                                                          js.jPlanList[0]['planList'][index]['longitude'] != null) {
                                                        CameraPosition cameraPosition = CameraPosition(
                                                            target: LatLng(
                                                                js.jPlanList[0]['planList'][index]['latitude'],
                                                                js.jPlanList[0]['planList'][index]['longitude']),
                                                            zoom: 12);
                                                        final GoogleMapController controller =
                                                            await js.mapController.future;
                                                        await controller.animateCamera(
                                                            CameraUpdate.newCameraPosition(cameraPosition));
                                                      }
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            width: 58,
                                                            height: 50,
                                                            decoration: BoxDecoration(
                                                              color: gray200,
                                                              border: Border.all(color: gray200),
                                                              borderRadius: BorderRadius.only(
                                                                topLeft: Radius.circular(4), // 좌측 상단 반경 4px
                                                                topRight: Radius.circular(0), // 우측 상단 반경 0px
                                                                bottomRight: Radius.circular(0), // 우측 하단 반경 0px
                                                                bottomLeft: Radius.circular(4), // 좌측 하단 반경 4px
                                                              ),
                                                            ),
                                                            child: Center(
                                                                child: Text(
                                                              '${js.jPlanList[0]['planList'][index]['startTime'].toString().substring(0, 5)}',
                                                              style: f12Gray800w500,
                                                            ))),
                                                        Expanded(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              border: Border.all(color: gray200),
                                                              borderRadius: BorderRadius.only(
                                                                topLeft: Radius.circular(0), // 좌측 상단 반경 4px
                                                                topRight: Radius.circular(4), // 우측 상단 반경 0px
                                                                bottomRight: Radius.circular(4), // 우측 하단 반경 0px
                                                                bottomLeft: Radius.circular(0), // 좌측 하단 반경 4px
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 10),
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  js.jPlanList[0]['planList'][index]['memo'] != ''
                                                                      ? PopupMenuButton(
                                                                          offset: Offset(-34, 35),
                                                                          shadowColor: Colors.black.withOpacity(0.4),
                                                                          shape: TooltipShape(
                                                                              borderColor: Color(
                                                                                  ts.selectTripList[0]['labelColor']),
                                                                              borderWidth: 1),
                                                                          child: SvgPicture.asset(
                                                                            'assets/icon/memo.svg',
                                                                            colorFilter: ColorFilter.mode(
                                                                                Color(
                                                                                    ts.selectTripList[0]['labelColor']),
                                                                                BlendMode.srcIn),
                                                                            fit: BoxFit.contain,
                                                                          ),
                                                                          color: Colors.white,
                                                                          itemBuilder: (_) => <PopupMenuEntry>[
                                                                            PopupMenuItem(
                                                                                enabled: false,
                                                                                padding: EdgeInsets.only(left: 10),
                                                                                child: Text(
                                                                                    '${js.jPlanList[0]['planList'][index]['memo']}',
                                                                                    style: f12mainw600(Color(
                                                                                        ts.selectTripList[0]
                                                                                            ['labelColor'])))),
                                                                          ],
                                                                        )
                                                                      : const SizedBox(),
                                                                  const SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Expanded(
                                                                      child: Text(
                                                                    '${js.jPlanList[0]['planList'][index]['title']}',
                                                                    style: f12Gray800w500,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  )),
                                                                  PopupMenuButton<int>(
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                    ),
                                                                    offset: const Offset(-20, 40),
                                                                    padding: EdgeInsets.zero,
                                                                    constraints: BoxConstraints(maxWidth: 125),
                                                                    menuPadding: EdgeInsets.zero,
                                                                    shadowColor: Colors.black.withOpacity(0.4),
                                                                    icon: SvgPicture.asset(
                                                                      'assets/icon/columnEllipsis.svg',
                                                                      fit: BoxFit.none,
                                                                    ),
                                                                    color: gray50,
                                                                    itemBuilder: (context) => <PopupMenuEntry<int>>[
                                                                      PopupMenuItem<int>(
                                                                        onTap: () {
                                                                          js.selectJplan.value =
                                                                              js.jPlanList[0]['planList'][index];
                                                                          Get.to(() => EditPlanPage());
                                                                        },
                                                                        padding: EdgeInsets.zero,
                                                                        value: 1,
                                                                        child: Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                  left: 12, right: 12),
                                                                              child: Row(
                                                                                mainAxisAlignment:
                                                                                    MainAxisAlignment.start,
                                                                                crossAxisAlignment:
                                                                                    CrossAxisAlignment.center,
                                                                                children: [
                                                                                  SvgPicture.asset(
                                                                                    'assets/icon/pencil.svg',
                                                                                    colorFilter: ColorFilter.mode(
                                                                                        gray600, BlendMode.srcIn),
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
                                                                        onTap: () {
                                                                          js.deleteJPlanList(
                                                                              js.jPlanList[0]['planList'][index]
                                                                                  ['planId'],
                                                                              js.jPlanList[0]['dayAfterStart']);
                                                                        },
                                                                        padding: EdgeInsets.zero,
                                                                        value: 2,
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 12),
                                                                          child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: 24,
                                                                                height: 24,
                                                                                child: SvgPicture.asset(
                                                                                  'assets/icon/trashCan.svg',
                                                                                  fit: BoxFit.none,
                                                                                  colorFilter: ColorFilter.mode(
                                                                                      gray600, BlendMode.srcIn),
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
                                                                          showLoading(context);
                                                                          Map data = {
                                                                            "planId": js.jPlanList[0]['planList'][index]
                                                                                ['planId'],
                                                                            "dayAfterStart": js.jPlanList[0]['planList']
                                                                                [index]['dayAfterStart'],
                                                                            "startTime": js.jPlanList[0]['planList']
                                                                                [index]['startTime'],
                                                                            "title": js.jPlanList[0]['planList'][index]
                                                                                ['title'],
                                                                            "memo": js.jPlanList[0]['planList'][index]
                                                                                ['memo'],
                                                                            "place": js.jPlanList[0]['planList'][index]
                                                                                        ['place'] ==
                                                                                    ''
                                                                                ? js.jPlanList[0]['planList'][index]
                                                                                    ['place']
                                                                                : '',
                                                                            "latitude": js.jPlanList[0]['planList']
                                                                                        [index]['place'] ==
                                                                                    ''
                                                                                ? js.jPlanList[0]['planList'][index]
                                                                                    ['latitude']
                                                                                : '',
                                                                            "longitude": js.jPlanList[0]['planList']
                                                                                        [index]['place'] ==
                                                                                    ''
                                                                                ? js.jPlanList[0]['planList'][index]
                                                                                    ['longitude']
                                                                                : '',
                                                                            "locker": true
                                                                          };
                                                                          await js.editJPlanList(data);
                                                                          Get.back();
                                                                        },
                                                                        padding: EdgeInsets.zero,
                                                                        value: 3,
                                                                        child: Padding(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: Platform.isAndroid ? 8 : 12),
                                                                          child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: 24,
                                                                                height: 24,
                                                                                child: SvgPicture.asset(
                                                                                  'assets/bottomNavi/locker.svg',
                                                                                  fit: BoxFit.none,
                                                                                  colorFilter: ColorFilter.mode(
                                                                                      gray600, BlendMode.srcIn),
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
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 4)
                                          ],
                                        );
                                      },
                                    )),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
        floatingActionButton: PlusFloatingButton(
          backgroundColor: gray900,
          onPressed: () {
            Get.to(() => AddPlanPage());
          },
        ));
  }
}
