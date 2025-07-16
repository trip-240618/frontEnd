import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';

import '../models/j_plan_state.dart';

class JPlanController extends GetxController {
  final TripRoomService _tripRoomService;

  JPlanController(
    this._tripRoomService,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  JPlanState _jPlanState = JPlanState();

  JPlanState get state => _jPlanState;

  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  ScrollController scrollController = ScrollController();

  final minHeight = 154.0;
  final maxHeight = 300.0;
  double dayItemWidth = 48;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _jPlanState = state.copyWith(
      mapLatitude: position.latitude,
      mapLongitude: position.longitude,
      jPlanStatus: JPlanStatus.success,
    );
    update();
  }

  void onMapDrag(double detail) {
    double nextHeight = state.googleMapHeight + detail;
    if (nextHeight < minHeight) nextHeight = minHeight;
    if (nextHeight > maxHeight) nextHeight = maxHeight;

    _jPlanState = state.copyWith(googleMapHeight: nextHeight);
    update();
  }

  /// sideEffect
  void onDayPressed(
    int index,
  ) {
    double scrollOffset = dayItemWidth * index;

    scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _jPlanState = state.copyWith(
      selectedDayIndex: index,
    );
    update();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
