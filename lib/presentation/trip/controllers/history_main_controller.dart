import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart' as cluster;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/core/permission/permission_state.dart';
import 'package:tripStory/core/permission/permission_type.dart';
import 'package:tripStory/core/permission/permisson.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/core/util/extension/date_extension.dart';
import 'package:tripStory/core/util/helper/route_helper.dart';
import 'package:tripStory/core/util/one_time_event.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/fetch_histories_usecase.dart';
import 'package:tripStory/presentation/global/location_service.dart';
import 'package:tripStory/presentation/global/marker_service.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/history_detail_param.dart';
import 'package:tripStory/presentation/trip/models/history_main_state.dart';
import 'package:tripStory/presentation/trip/widgets/history_map_marker.dart';

class HistoryMainController extends GetxController {
  final TripRoomService _tripRoomService;
  final MarkerIconService _markerIconService;
  final FetchHistoriesUsecase _fetchHistoriesUsecase;

  HistoryMainController(
    this._tripRoomService,
    this._markerIconService,
    this._fetchHistoriesUsecase,
  );

  DraggableScrollableController scrollableController = DraggableScrollableController();
  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  cluster.ClusterManager<MarkerItem>? manager;

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  HistoryMainState _historyMainState = HistoryMainState();

  HistoryMainState get state => _historyMainState;

  final Map<String, Marker> _markerCache = {};

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    _initializeClusterManager();
  }

  Future<void> _initializeData() async {
    await _getHistoryData();
    _getCurrentLocation();
  }

  void _initializeClusterManager() {
    manager = cluster.ClusterManager<MarkerItem>(
      [],
      _updateMarkers,
      markerBuilder: _createClusterMarker,
    );
  }

  Future<void> refreshData() async {
    await _getHistoryData();
  }

  Future<void> _getCurrentLocation() async {
    final position = await LocationService().getCurrentLocation();
    _historyMainState = state.copyWith(
      currentLatitude: position.latitude,
      currentLongitude: position.longitude,
      historyStatus: HistoryStatus.success,
    );

    update(['map']);
  }

  Future<void> _getHistoryData() async {
    if (tripRoomInfo?.id == null) return;

    final result = await _fetchHistoriesUsecase.call(tripRoomInfo?.id ?? 0);

    result.fold(
      (failure) {},
      (data) {
        final histories = _fillPhotoDates(data);
        _historyMainState = state.copyWith(
          histories: histories,
        );
        update(['list']);
        _updateMarkersFromHistories(data);
      },
    );
  }

  List<HistoriesEntity> _fillPhotoDates(List<HistoriesEntity> histories) {
    final startDate = tripRoomInfo?.startDate;
    final endDate = tripRoomInfo?.endDate;

    if (startDate == null || endDate == null) {
      return histories;
    }

    final historyMap = {
      for (var history in histories) history.photoDate: history,
    };

    return List.generate(
      endDate.difference(startDate).inDays + 1,
      (index) {
        final currentDate = startDate.add(Duration(days: index)).formatYMDWithHyphen();

        return historyMap[currentDate] ?? HistoriesEntity(photoDate: currentDate, historyList: []);
      },
    );
  }

  /// 마커
  Future<Marker> _createClusterMarker(cluster.Cluster<MarkerItem> clusterItem) async {
    final isSingle = !clusterItem.isMultiple;
    final item = clusterItem.items.first;
    final count = isSingle ? 1 : clusterItem.count;
    final cacheKey = "cluster_${tripRoomInfo?.id}_${clusterItem.getId()}";

    final icon = await _markerIconService.renderIconWithBuilder(
      cacheKey: cacheKey,
      size: Size(300, 400),
      widget: () => HistoryMapMarker(
        imageUrl: item.thumbnailUrl,
        count: count,
      ),
    );

    return Marker(
      markerId: MarkerId(clusterItem.getId()),
      position: clusterItem.location,
      icon: icon,
      onTap: () {},
    );
  }

  void _updateMarkersFromHistories(List<HistoriesEntity> histories) {
    final historyList = histories.expand((h) => h.historyList).toList();
    final validHistories = historyList.where((history) => history.isValidLocation).toList();

    final markerItems = validHistories
        .map((history) => MarkerItem(
              id: history.id,
              latitude: history.latitude ?? 0.0,
              longitude: history.longitude ?? 0.0,
              thumbnailUrl: history.thumbnail,
            ))
        .toList();
    manager?.setItems(markerItems);
    manager?.updateMap();
  }

  void _updateMarkers(Set<Marker> newMarkers) {
    _historyMainState = state.copyWith(
      markers: newMarkers,
    );
    update(['map']);
  }

  /// side Effect

  void onSearchBarPressed() => Get.toNamed(Routes.historySearch);

  Future<void> onImagePressed(
    int index,
    int selectedHistoryId,
  ) async {
    final idList = state.histories[index].historyList.map((history) => history.id).toList();
    final HistoryDetailParam param = HistoryDetailParam(
      selectedHistoryId: selectedHistoryId,
      historiesIds: idList,
    );
    Get.toNamed(Routes.historyDetail, arguments: param);
  }

  Future<void> onPhotoPressed() async {
    final status = await getPermissionStatus(PermissionType.photoManager);

    if (status == PermissionState.granted) {
      _historyMainState = state.copyWith(
        showDaySelectedDialog: OneTimeEvent(true),
      );
    } else {
      _historyMainState = state.copyWith(
        showPhotoPermissionDialog: OneTimeEvent(true),
      );
    }
    update(["dialog"]);
  }

  void onSelectedDayPressed(DateTime selectedDay) {
    _historyMainState = state.copyWith(
      selectedDay: selectedDay,
    );
    update();
  }

  void onSelectedDayDialogConfirmPressed() {
    if (state.selectedDay == null) return;

    RouteHelper.closeOverlaysAndToNamed(
      Routes.album,
      arguments: state.selectedDay,
    );

    _historyMainState = state.copyWith(
      selectedDay: null,
    );
    update();
  }

  void onHistoryItemHeaderPressed(int index) {
    if (state.histories[index].historyList.isEmpty) return;

    Get.toNamed(
      Routes.historyList,
      arguments: DateTime.parse(state.histories[index].photoDate),
    );
  }

  void onNavigateToHome() => Get.back();
}
