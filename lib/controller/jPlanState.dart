import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/controller/tripState.dart';

import '../app/api/flightApi.dart';
import '../app/config/dio_client.dart';

class JPlanState extends GetxController{
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final isGoogleExpanded = true.obs;
  final isSorting = false.obs;
  final RxList flightList = [].obs; /// 항공권 저장하는 리스트
  final apiFlightClient = ApiFlightClient(DioClient());
  final selectedDate = ''.obs; /// 선택된 날짜를 저장하는 값 ex)항공권, 일정 추가 시 선택된 날짜

  /// AddPlan에서 여행장소 검색 결과를 저장하는 리스트
  final RxList searchLocation = [].obs;


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

  /// 항공권 목록 정보 가져오기
  Future<void> getFlightList()async{
    flightList.clear();
    flightList.value = await apiFlightClient.flightGet();
    print('flightList?${flightList.value}');
    flightList.refresh();
  }

  /// 선택된 날짜를 startDate 초기화
  Future<void> selectedDateReset()async {
    final ts = Get.put(TripState());
    selectedDate.value = ts.selectTripList[0]['startDate'];
  }

  /// 다가오는 여행 가져오기
  Future<void> searchFlight(int flightNumber, String carrierCode)async{
    flightList.clear();
    flightList.value = await apiFlightClient.flightSearch(flightNumber, carrierCode);
    print('flightList?${flightList.value}');
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