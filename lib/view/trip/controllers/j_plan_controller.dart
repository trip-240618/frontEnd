import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/domain/entities/j_socket_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/repositories/j_socket_repository.dart';
import 'package:tripStory/domain/usecases/fetch_j_plan_usecase.dart';
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/view/trip/models/j_plan_state.dart';

class JPlanController extends GetxController {
  final JSocketRepository _jSocketRepository;
  final TripRoomService _tripRoomService;
  final FetchJPlanUsecase _fetchJPlanUsecase;

  JPlanController(
    this._jSocketRepository,
    this._tripRoomService,
    this._fetchJPlanUsecase,
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
    _jPlanState = state.copyWith(
      selectedDate: tripRoomInfo?.startDate,
    );
    _initializeData();
  }

  Future<void> _initializeData() async {
    await Future.wait([
      getCurrentLocation(),
      planSocketInit(),
      getJPlanData(),
    ]);
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
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

  Future<void> getJPlanData() async {
    final params = Tuple3(
      tripRoomInfo?.id ?? 0,
      tripRoomInfo?.dayAfterStartFrom(state.selectedDate ?? DateTime.now()) ?? 1,
      false,
    );

    final result = await _fetchJPlanUsecase.call(params);

    result.fold(
      (failure) {},
      (plans) {
        _jPlanState = state.copyWith(
          plans: plans,
        );
        update();
      },
    );
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
