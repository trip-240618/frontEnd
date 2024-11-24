import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/controller/tripState.dart';
import '../component/dialog/dialog.dart';
import '../util/custom_marker.dart';

class MapState extends GetxController{
  final ts = Get.put(TripState());
  final hs = Get.put(HistoryState());
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  RxSet<Marker> markers = <Marker>{}.obs; /// 커스텀 마커
  RxSet<Marker> selectedMarkers = <Marker>{}.obs; /// 선택한 기록 마커

  @override
  void onInit() async{
    super.onInit();
  }

  @override
  void onClose()async{
    super.onClose();
  }

  /// 전체 지도에 마커 표시
  Future<void> addMarkersFromHistory() async {
    markers.clear();
    List<Future<void>> futures = [];

    for (int i = 0; i < hs.historyList.length; i++) {
      for(int j=0;j<hs.historyList[i]['historyList'].length;j++){
        if(hs.historyList[i]['historyList'][j]['latitude']!= 0.0 && hs.historyList[i]['historyList'][j]['longitude']!=0.0){
          futures.add(createMarker(
            index: i + 1,
            history: hs.historyList[i]['historyList'][j],
          ));
        }
      }
    }
    await Future.wait(futures);
  }

  /// 개별 마커 생성 및 추가 함수
  Future<void> createMarker({required int index, required Map<String, dynamic> history}) async {
    final icon = await getCustomIcon(index, history['thumbnail']);
    final marker = Marker(
      markerId: MarkerId(DateTime.now().toString()),
      position: LatLng(history['latitude'], history['longitude']),
      icon: icon,
      onTap: () {},
    );
    markers.add(marker);
  }
  /// 선택한 사진 마커 표시
  Future<void> addMarkersFullMap() async {
    selectedMarkers.clear();
    for (int i = 0; i < hs.searchList.length; i++) {
        if(hs.searchList[0]['historyList'][i]['latitude']!= 0.0 && hs.searchList[0]['historyList'][i]['longitude']!=0.0){
          final icon = await getCustomIcon(i+1, hs.searchList[0]['historyList'][i]['thumbnail']);
          final marker = Marker(
            markerId: MarkerId(DateTime.now().toString()),
            position: LatLng(hs.searchList[0]['historyList'][i]['latitude'], hs.searchList[0]['historyList'][i]['longitude']),
            icon: icon,
            onTap: () {
              // 마커 클릭 시 행동
            },
          );
          selectedMarkers.add(marker); // 반응형 변수에 마커 추가
        }
    }
  }
  /// 마커 지우기
  void removeMarker(MarkerId markerId) {}

  /// 현재 내 위치로 카메라 lat,lng 초기화
  Future<void> getCurrentLocation(BuildContext context) async{
    bool requestCheck = await requestLocationPermission(context);
    if(requestCheck){
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
      );
      latitude.value = position.latitude;
      longitude.value = position.longitude;
    }else{
    }
  }
}