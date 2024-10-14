import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/app/api/jPlanApi.dart';
import 'package:tripStory/controller/tripState.dart';
import '../app/api/flightApi.dart';
import '../app/config/dio_client.dart';

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
  final RxMap selectJplan = {}.obs; /// 선택된 jplan 리스트

  /// jplan add
  final Rx<DateTime> addSelectedDateTime = DateTime.now().obs;
  final addDate = ''.obs; /// 추가 시킬 때 날짜
  final editDate = ''.obs; /// 수정 할 때 날짜 변수
  /// planB jList
  final RxList planBJList = [].obs; /// plan B j data 리스트
  final RxMap firstSwapList = {}.obs; /// 스왑사용시 첫번째로 값 넣는곳

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

  /// jplanList 가져오기
  Future<void> getJPlanList(int day ,bool locker)async{
    jPlanList.value = await apijplanClient.getJPlanList(ts.selectTripList[0]['id'], day, locker);
    jPlanList.forEach((day) {
      day['planList'] = day['planList'].map((plan) {
        plan['checked'] = false;
        plan['checked2'] = false;
        return plan;
      }).toList();
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
  Future<void> deleteJPlanList(int planId)async{
    await apijplanClient.deleteJPlan(ts.selectTripList[0]['id'], planId);
    jPlanList.refresh();
  }
  /// jplanList 스왑
  Future<void> swapJPlan(Map data)async {
    await apijplanClient.swapJPlan(ts.selectTripList[0]['id'],data);
  }

  /// planB jList 가져오기
  Future<void> getPlanBJList(int day, bool locker)async{
    planBJList.value = await apijplanClient.getPlanBJList(ts.selectTripList[0]['id'], day, locker);
    print('?? ${planBJList}');
    planBJList.refresh();
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