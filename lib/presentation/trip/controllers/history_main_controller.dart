import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart' as cluster;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/history_main_state.dart';

class HistoryMainController extends GetxController {
  final TripRoomService _tripRoomService;

  HistoryMainController(
    this._tripRoomService,
  );

  DraggableScrollableController scrollableController = DraggableScrollableController();
  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  cluster.ClusterManager<MarkerItem>? manager;

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  HistoryMainState _historyMainState = HistoryMainState();

  HistoryMainState get state => _historyMainState;

// @override
// void onInit() {
//   super.onInit();
//   manager = cluster.ClusterManager(
//     items,
//     _updateMarkers,
//     markerBuilder: _markerBuilder,
//     levels: [1, 4.25, 6.75, 10.0, 11.5, 13.0, 14.5, 16.0, 16.5, 18.0],
//   );
// }
//
// Future<void> _getHistoryData() async {}
}
