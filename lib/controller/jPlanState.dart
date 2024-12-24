import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/app/api/jPlanApi.dart';
import 'package:tripStory/controller/tripState.dart';
import '../app/api/flightApi.dart';
import '../app/config/dio_client.dart';
import '../app/permission/permission.dart';
import '../util/custom_marker.dart';
import 'dart:math';
class JPlanState extends GetxController{
  final apiFlightClient = ApiFlightClient(DioClient());
  final apijplanClient = ApiJPlanClient(DioClient());
  final ts = Get.put(TripState());

  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  ScrollController listController = ScrollController();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final isGoogleExpanded = false.obs;
  final isSorting = false.obs; /// 수정 권한 버튼
  final RxList flightList = [].obs; /// 항공권 저장하는 리스트

  final selectedDate = ''.obs; /// 선택된 날짜를 저장하는 값 ex)항공권, 일정 추가 시 선택된 날짜
  final selectedIdx = 0.obs; /// 선택된 날짜 인덱스

  /// AddPlan에서 여행장소 검색 결과를 저장하는 리스트
  final RxList searchLocation = [].obs;

  /// jplan
  final RxList jPlanList = [].obs; /// jplan data 리스트
  final RxMap selectJplan = {}.obs; /// 수정 할 때 선택된 jplan 리스트
  final RxList editPlanJList = [].obs; /// 수정할 때 리스트
  final RxMap firstSwapList = {}.obs; /// 스왑 사용시 첫번째로 값 넣는곳

  RxSet<Marker> markers = <Marker>{}.obs; /// 커스텀 마커
  RxSet<Polyline> polyline = <Polyline>{}.obs; /// 커스텀 마커
  /// jplan add
  final Rx<DateTime> addSelectedDateTime = DateTime.now().obs;
  final addDate = ''.obs; /// 추가 시킬 때 날짜
  final editDate = ''.obs; /// 수정 할 때 날짜 변수
  /// planB
  final planBSelectedIdx = 0.obs; /// planB선택된 날짜 인덱스
  final planBSelectedDate = ''.obs; /// planB 선택된 날짜를 저장하는 값
  final RxList planBJList = [].obs; /// plan B j data 리스트
  final RxMap selectPlanBJList = {}.obs; /// 수정 할 때 선택된 plan B j  리스트
  /// planB add
  final Rx<DateTime> planBAddSelectedDateTime = DateTime.now().obs;
  final planBAddDate = ''.obs; /// 추가 시킬 때 날짜


  @override
  void onInit() {
    listController = ScrollController();
    super.onInit();
  }

  @override
  void dispose() {
    listController.dispose();
  }

  /// 초기화 함수
  Future<void> resetState() async{
    isGoogleExpanded.value = false;
    isSorting.value = false;
    flightList.clear();
    selectedDate.value = '';
    selectedIdx.value = 0;
    searchLocation.clear();
    jPlanList.clear();
    selectJplan.clear();
    editPlanJList.clear();
    firstSwapList.clear();
    markers.clear();
    polyline.clear();
    addSelectedDateTime.value = DateTime.now();
    addDate.value = '';
    editDate.value = '';
    mapController = Completer<GoogleMapController>();
  }

  /// 스크롤을 특정 인덱스로 이동시키는 함수
  void scrollToList(int index) {
    double itemHeight = 54;
    double scrollOffset = itemHeight * index;
    listController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  /// 지도에 마커 표시
  Future<void> jplnaMarkerSet() async {
    markers.clear();
    polyline.clear();
    List<LatLng> poly = [];
    int countNum = 1;
    if (jPlanList.isNotEmpty) {
      try {
        for (int i = 0; i < jPlanList[0]['planList'].length; i++) {
          if (jPlanList[0]['planList'][i]['latitude'] != null &&
              jPlanList[0]['planList'][i]['longitude'] != null) {
            // 마커 생성
            final marker = Marker(
              markerId: MarkerId(DateTime.now().toString()), // 고유 마커 ID
              position: LatLng(jPlanList[0]['planList'][i]['latitude'], jPlanList[0]['planList'][i]['longitude']),
              icon: await getCustomIcon2(countNum),
              onTap: () async{
                CameraPosition cameraPosition= CameraPosition(
                    target: LatLng(jPlanList[0]['planList'][i]['latitude'], jPlanList[0]['planList'][i]['longitude']),
                    zoom: 14);
                final GoogleMapController controller = await mapController.future;
                await controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
                scrollToList(i);
              },
            );
            countNum ++;
            markers.add(marker);
            poly.add(LatLng(jPlanList[0]['planList'][i]['latitude'], jPlanList[0]['planList'][i]['longitude']));
          }
        }
        if (poly.isNotEmpty) {
          polyline.add(
            Polyline(
              polylineId: PolylineId('polyline_1'),
              points: poly, // 전체 경로 좌표 리스트
              color: Color(ts.selectTripList[0]['labelColor']), // 경로 색상
              width: 5, // 경로 두께
            ),
          );
        }
      } catch (e) {
        // print('에러 발생: $e'); // 에러가 발생하면 출력
      }
    }
  }
  /// jplanList 가져오기
  Future<void> getJPlanList(int day ,bool locker)async{
    jPlanList.value = await apijplanClient.getJPlanList(ts.selectTripList[0]['id'], day, locker);
    jPlanList.forEach((day) {
       day['waitList']=[];
       day['checked'] = true;
    });
    jPlanList.refresh();
  }

  /// jplanList 추가
  Future<void> addJPlanList(Map data)async{
    await apijplanClient.addJPlanList(ts.selectTripList[0]['id'],data);
    jPlanList.refresh();
  }
  /// jplanList 수정
  Future<void> editJPlanList(Map data)async{
    await apijplanClient.editJPlanList(ts.selectTripList[0]['id'],data);
    jPlanList.refresh();
  }
  /// jplanList 삭제
  Future<void> deleteJPlanList(int planId,int day)async{
    await apijplanClient.deleteJPlan(ts.selectTripList[0]['id'], planId,day);
    jPlanList.refresh();
  }
  /// jplanList 스왑
  Future<void> swapJPlan(Map data)async {
    await apijplanClient.swapJPlan(ts.selectTripList[0]['id'],data);
  }
  /// jplanList 스왑 취소
  Future<void> deleteSwapJPlan(int day)async {
    await apijplanClient.deleteSwapJPlan(ts.selectTripList[0]['id'],day);
  }

  /// planB jList 가져오기
  Future<void> getPlanBJList()async{
    planBJList.value = await apijplanClient.getPlanBJList(ts.selectTripList[0]['id'], true);
    planBJList.forEach((day) {
      day['checked'] = true;
    });
    planBJList.sort((a, b) {
      if (a['dayAfterStart'] == -1) return 1; // a가 null이면 뒤로 보냄
      if (b['dayAfterStart'] == -1) return -1; // b가 null이면 a가 앞에 옴
      return a['dayAfterStart'].compareTo(b['dayAfterStart']); // 오름차순 정렬
    });
    planBJList.refresh();
  }

  /// planB jList 추가
  Future<void> addPlanBJList(Map data)async{
    await apijplanClient.addBJPlanList(ts.selectTripList[0]['id'],data);
    planBJList.refresh();
  }
  /// planB jList 삭제
  Future<void> deletePlanBJList(int planId,int? day)async{
   await apijplanClient.deleteBJPlan(ts.selectTripList[0]['id'], planId,day??0);
   jPlanList.refresh();
  }


  /// 항공권 목록 정보 가져오기
  Future<void> getFlightList()async{
    flightList.clear();
    flightList.value = await apiFlightClient.flightGet();
    flightList.refresh();
  }

  /// 선택된 날짜를 startDate 초기화
  Future<void> selectedDateReset()async {
    final ts = Get.put(TripState());
    selectedDate.value = ts.selectTripList[0]['startDate'];
  }

  /// 항공편 검색
  Future<void> searchFlight(int flightNumber, String carrierCode)async{
    flightList.value = await apiFlightClient.flightSearch(flightNumber, carrierCode);
    flightList.refresh();
  }

  /// 항공권 삭제
  Future<void> deleteFlight()async {
    await apiFlightClient.flightDelete();
    flightList.clear();
  }

  /// 항공권 생성
  Future<void> createFlight(String airlineCode)async {
    flightList.value = await apiFlightClient.flightCreate(
      airlineCode,
      flightList[0]['airlineNumber'],
      flightList[0]['departureDate'],
      flightList[0]['departureAirport'],
      flightList[0]['departureAirport_kr'],
      flightList[0]['arrivalDate'],
      flightList[0]['arrivalAirport'],
      flightList[0]['arrivalAirport_kr'],
    );
  }
  /// 현재 내 위치로 카메라 lat,lng 초기화
  Future<void> getCurrentLocation(BuildContext context) async {
    bool requestCheck = await requestLocationPermission(context);
    if (requestCheck) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
      );
      latitude.value = position.latitude;
      longitude.value = position.longitude;
    }
  }
  // /// 지도에 일정이 있으면 내 일정 첫번째로, 아니면 현재 내 위치로
  // Future<CameraPosition> getInitialCameraPosition(BuildContext context) async {
  //   /// 초기 데이터 가져오기
  //   await getJPlanList(1, false);
  //   bool requestCheck = await requestLocationPermission(context);
  //   if (requestCheck) {
  //     /// 위치 정보가 있는 첫 번째 계획 찾기
  //     var targetPlan = jPlanList[0]['planList']?.firstWhere(
  //           (plan) => plan['latitude'] != null && plan['longitude'] != null,
  //       orElse: () => null,
  //     );
  //     if (targetPlan != null) {
  //       return CameraPosition(
  //         target: LatLng(targetPlan['latitude'], targetPlan['longitude']),
  //         zoom: 14.4746,
  //       );
  //     } else {
  //       Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high,
  //       );
  //       return CameraPosition(
  //         target: LatLng(position.latitude, position.longitude),
  //         zoom: 14.4746,
  //       );
  //     }
  //   }else{
  //     return CameraPosition(
  //       target: LatLng(latitude.value, longitude.value),
  //       zoom: 14.4746,
  //     );
  //   }
  // }

}