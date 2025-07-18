import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/domain/entities/j_socket_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/repositories/j_socket_repository.dart';
import 'package:tripStory/router/routes.dart';

import '../models/j_plan_state.dart';

class JPlanController extends GetxController {
  final JSocketRepository _jSocketRepository;
  final TripRoomService _tripRoomService;

  JPlanController(
    this._jSocketRepository,
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
    planSocketInit();

    _jPlanState = state.copyWith(
      selectedDate: tripRoomInfo?.startDate,
    );
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

  Future<void> planSocketInit() async {
    final tripId = tripRoomInfo?.id;
    if (tripId == null) return;

    await _jSocketRepository.connectToTrip(tripId);

    _jSocketRepository.listenToPlans(tripId).listen((event) {
      switch (event) {
        case PlanAdded(:final plan):
          print("📦 Plan 추가됨: $plan");
          // // 예: 리스트에 추가
          // _jPlanState = state.copyWith(
          //   plans: [...state.plans, plan],
          // );
          update();
          break;
      }
    });
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
    DateTime? selectedDate,
  ) {
    double scrollOffset = dayItemWidth * index;

    scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _jPlanState = state.copyWith(
      selectedDayIndex: index,
      selectedDate: selectedDate,
    );
    update();
  }

  void onAddPlanPressed() {
    Get.toNamed(
      Routes.tripJPlanAdd,
      arguments: state.selectedDate,
    );
  }

  @override
  void onClose() {
    _jSocketRepository.disconnect();
    scrollController.dispose();
    super.onClose();
  }
}
