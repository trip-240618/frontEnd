import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/app/api/jPlanApi.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/util/color.dart';
import '../app/api/flightApi.dart';
import '../app/config/dio_client.dart';
import '../util/custom_marker.dart';
import 'dart:math';
class JPlanState extends GetxController{
  final apiFlightClient = ApiFlightClient(DioClient());
  final apijplanClient = ApiJPlanClient(DioClient());
  final ts = Get.put(TripState());

  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();


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
  /// planB jList
  final RxList planBJList = [].obs; /// plan B j data 리스트
  final RxMap selectPlanBJList = {}.obs; /// 수정 할 때 선택된 plan B j  리스트


  @override
  void onInit() {
    latitude.value = 36.35475233611197;
    longitude.value = 127.34170655688537;
    super.onInit();
  }

  @override
  void dispose() {
    isGoogleExpanded.value = true;
    super.dispose();
  }

  /// 지도에 마커 표시
  Future<void> jplnaMarkerSet() async {
    markers.clear();
    polyline.clear();
    List<LatLng> poly = []; // 전체 경로를 담을 리스트

    if (jPlanList.isNotEmpty) {
      try {
        for (int i = 0; i < jPlanList[0]['planList'].length; i++) {
          if (jPlanList[0]['planList'][i]['latitude'] != null &&
              jPlanList[0]['planList'][i]['longitude'] != null) {
            // Custom icon 생성
            final icon = await getCustomIcon2(i + 1);

            // 마커 생성
            final marker = Marker(
              markerId: MarkerId(DateTime.now().toString()), // 고유 마커 ID
              position: LatLng(jPlanList[0]['planList'][i]['latitude'],
                  jPlanList[0]['planList'][i]['longitude']),
              icon: icon,
              onTap: () {
                // 마커 클릭 시 실행할 코드
              },
            );
            markers.add(marker);
            poly.add(LatLng(jPlanList[0]['planList'][i]['latitude'],
                jPlanList[0]['planList'][i]['longitude']));
          }
        }
        if (poly.isNotEmpty) {
          mapController.future.then((value){print('val?? ${value.getZoomLevel()}');});
          polyline.add(
            Polyline(
              polylineId: PolylineId('polyline_1'),
              // patterns: [PatternItem.dash(20), PatternItem.gap(80),],
              points: poly, // 전체 경로 좌표 리스트
              color: Color(ts.selectTripList[0]['labelColor']), // 경로 색상
              width: 8, // 경로 두께
            ),
          );
        }
      } catch (e) {
        print('에러 발생: $e'); // 에러가 발생하면 출력
      }
    }
  }
  List<LatLng> simplifyPolyline(List<LatLng> points, double tolerance) {
    if (points.isEmpty) return [];

    List<LatLng> simplified = [];

    // 첫 번째와 마지막 점을 추가
    simplified.add(points.first);
    simplified.add(points.last);

    // 재귀적으로 단순화하는 함수
    void simplify(List<LatLng> polyline, List<LatLng> output) {
      if (polyline.length < 3) {
        output.addAll(polyline);
        return;
      }

      double maxDistance = 0;
      int index = 0;

      // 첫 번째와 마지막 점을 기준으로 최대 거리 찾기
      for (int i = 1; i < polyline.length - 1; i++) {
        double distance = pointToLineDistance(polyline[i], polyline.first, polyline.last);
        if (distance > maxDistance) {
          maxDistance = distance;
          index = i;
        }
      }

      // 최대 거리가 주어진 허용 오차보다 큰 경우
      if (maxDistance > tolerance) {
        simplify(polyline.sublist(0, index + 1), output);
        simplify(polyline.sublist(index), output);
      }
    }

    simplify(points, simplified);
    return simplified;
  }
  // 점과 선 사이의 거리 계산
  double pointToLineDistance(LatLng point, LatLng start, LatLng end) {
    double A = point.latitude - start.latitude;
    double B = point.longitude - start.longitude;
    double C = end.latitude - start.latitude;
    double D = end.longitude - start.longitude;

    double dot = A * C + B * D;
    double len_sq = C * C + D * D;
    double param = -1.0;

    if (len_sq != 0) { // 0으로 나누지 않도록
      param = dot / len_sq;
    }

    double xx, yy;

    if (param < 0) {
      xx = start.latitude;
      yy = start.longitude;
    } else if (param > 1) {
      xx = end.latitude;
      yy = end.longitude;
    } else {
      xx = start.latitude + param * C;
      yy = start.longitude + param * D;
    }

    double dx = point.latitude - xx;
    double dy = point.longitude - yy;
    return sqrt(dx * dx + dy * dy); ;
  }

  /// jplanList 가져오기
  Future<void> getJPlanList(int day ,bool locker)async{
    jPlanList.value = await apijplanClient.getJPlanList(ts.selectTripList[0]['id'], day, locker);
    jPlanList.forEach((day) {
       day['waitList']=[];
       day['checked'] = true;
    });
    print('?? ${jPlanList}');
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
    print('planBJList?? ${planBJList}');
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




}