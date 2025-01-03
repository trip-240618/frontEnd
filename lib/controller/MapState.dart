import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart' as cluster;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/controller/tripState.dart';
import '../util/custom_marker.dart';
import '../util/history_cluster_item.dart';

class MapState extends GetxController{
  final ts = Get.put(TripState());
  final hs = Get.put(HistoryState());
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  RxSet<Marker> markers = <Marker>{}.obs; /// 커스텀 마커
  RxSet<Marker> selectedMarkers = <Marker>{}.obs; /// 선택한 기록 마커
  final RxMap<String, Uint8List> imageCache = <String, Uint8List>{}.obs;

  /// 2025-01-03
  late cluster.ClusterManager manager;
  final items = <HistoryClusterItem>[].obs;

  @override
  void onInit() {
    manager = initClusterManager();
    super.onInit();
  }
  /// 클러스터 init
  void initToClusterItems(List<dynamic> historyList) {
    items.clear();
    for (int i = 0; i < historyList.length; i++) {
      for (int j = 0; j < historyList[i]['historyList'].length; j++) {
        final history = historyList[i]['historyList'][j];
        if (history['latitude'] != null &&
            history['longitude'] != null &&
            history['latitude'] != 0.0 &&
            history['longitude'] != 0.0) {
          final clusterItem = HistoryClusterItem(
            latLng: LatLng(history['latitude'], history['longitude']),
            index: i+1,
            thumbnailUrl: history['thumbnail'] ?? '',
          );
          items.add(clusterItem);
        }
      }
    }
    manager.setItems(items);
  }

  cluster.ClusterManager<HistoryClusterItem> initClusterManager() {
    return cluster.ClusterManager(
      items,
      _updateMarkers,
      markerBuilder: _markerBuilder,

    );
  }

  void _updateMarkers(Set<Marker> updatedMarkers) {
    markers.value = updatedMarkers;
  }

  Future<Marker> Function(cluster.Cluster<HistoryClusterItem>) get _markerBuilder => (cluster) async {
    final HistoryClusterItem singleItem = cluster.items.first;
    return Marker(
      markerId: MarkerId(cluster.getId()),
      position: singleItem.latLng,
      onTap: () {
        cluster.items.forEach((p) => print(p));
      },
      icon: await getCustomIcon(cluster.count, singleItem.thumbnailUrl),
    );
  };

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