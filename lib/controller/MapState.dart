import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/controller/tripState.dart';
import '../util/custom_marker.dart';

class MapState extends GetxController{
  final ts = Get.put(TripState());
  final hs = Get.put(HistoryState());
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  RxSet<Marker> markers = <Marker>{}.obs; /// 커스텀 마커
  RxSet<Marker> selectedMarkers = <Marker>{}.obs; /// 선택한 기록 마커
  final RxMap<String, Uint8List> imageCache = <String, Uint8List>{}.obs;
  /// 전체 지도에 마커 표시
  Future<void> addMarkersFromHistory() async {
    markers.clear();
    for (int i = 0; i < hs.historyList.length; i++) {
      for(int j=0;j<hs.historyList[i]['historyList'].length;j++){
        if(hs.historyList[i]['historyList'][j]['latitude']!=null&&
            hs.historyList[i]['historyList'][j]['longitude']!=null&&
            hs.historyList[i]['historyList'][j]['latitude']!= 0.0 &&
            hs.historyList[i]['historyList'][j]['longitude']!=0.0){
          createMarker(
              index: i + 1,
              history: hs.historyList[i]['historyList'][j],
              targetMarkers: markers
          );
        }
      }
    }
  }

  /// 개별 마커 생성 및 추가 함수
  Future<void> createMarker({
    required int index,
    required Map<String, dynamic> history,
    required RxSet<Marker> targetMarkers,
  }) async {
    final icon = await getCustomIcon(index, history['thumbnail']);
    final marker = Marker(
      markerId: MarkerId(DateTime.now().toString()),
      position: LatLng(history['latitude'], history['longitude']),
      icon: icon,
      onTap: () {},
    );
    targetMarkers.add(marker);
  }

  /// 선택한 지도 전체 사진 마커 표시
  Future<void> addMarkersFullMap() async {
    selectedMarkers.clear();
    List<Future<void>> futures = [];
    final List<String> dateList = List.generate(
        DateTime.parse('${ts.selectTripList[0]['endDate']}').difference(DateTime.parse('${ts.selectTripList[0]['startDate']}')).inDays + 1, (index) => DateFormat('yyyy-MM-dd').format(
      DateTime.parse('${ts.selectTripList[0]['startDate']}').add(Duration(days: index))));
    for (int i = 0; i < hs.searchList.length; i++) {
        if(hs.searchList[i]['latitude']!= 0.0 && hs.searchList[i]['longitude']!=0.0){
          futures.add(createMarker(
              index: dateList.indexOf(hs.searchList[i]['photoDate'])+1,
              history: hs.searchList[i],
              targetMarkers: selectedMarkers
          ));
        }
      }
    await Future.wait(futures);
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