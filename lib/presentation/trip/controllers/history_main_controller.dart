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
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/history_main_state.dart';

class HistoryMainController extends GetxController {
  final TripRoomService _tripRoomService;
  final FetchHistoriesUsecase _fetchHistoriesUsecase;

  HistoryMainController(
    this._tripRoomService,
    this._fetchHistoriesUsecase,
  );

  DraggableScrollableController scrollableController = DraggableScrollableController();
  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  cluster.ClusterManager<MarkerItem>? manager;

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  HistoryMainState _historyMainState = HistoryMainState();

  HistoryMainState get state => _historyMainState;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    // manager = cluster.ClusterManager(
    //   items,
    //   _updateMarkers,
    //   markerBuilder: _markerBuilder,
    //   levels: [1, 4.25, 6.75, 10.0, 11.5, 13.0, 14.5, 16.0, 16.5, 18.0],
    // );
  }

  Future<void> _initializeData() async {
    await Future.wait([
      _getCurrentLocation(),
      _getHistoryData(),
    ]);
  }

  Future<void> _getCurrentLocation() async {
    final position = await LocationService().getCurrentLocation();
    _historyMainState = state.copyWith(
      currentLatitude: position.latitude,
      currentLongitude: position.longitude,
      historyStatus: HistoryStatus.success,
    );

    update();
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

        update();
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

        return historyMap[currentDate] ??
            HistoriesEntity(
              photoDate: currentDate,
              historyList: [],
            );
      },
    );
  }

  Future<void> onPhotoPressed() async {
    final status = await getPermissionStatus(PermissionType.photoManager);

    if (status == PermissionState.granted) {
      _historyMainState = state.copyWith(
        showDaySelectedDialog: OneTimeEvent(true),
      );
      update();
    } else {
      _historyMainState = state.copyWith(
        showPhotoPermissionDialog: OneTimeEvent(true),
      );
      update();
    }
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
}
