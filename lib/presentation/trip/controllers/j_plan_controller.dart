import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/core/util/helper/route_helper.dart';
import 'package:tripStory/core/util/one_time_event.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/j_plan_entity.dart';
import 'package:tripStory/domain/entities/j_socket_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/delete_flight_usecase.dart';
import 'package:tripStory/domain/usecases/delete_j_plan_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_flight_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_j_plan_usecase.dart';
import 'package:tripStory/domain/usecases/j_plan_connect_socket_usecase.dart';
import 'package:tripStory/domain/usecases/j_plan_disconnect_socket_usecase.dart';
import 'package:tripStory/domain/usecases/j_plan_listen_socket_usecase.dart';
import 'package:tripStory/domain/usecases/j_plan_swap_register_usecase.dart';
import 'package:tripStory/domain/usecases/move_j_plan_locker_usecase.dart';
import 'package:tripStory/presentation/global/marker_service.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/j_plan_edit_param.dart';
import 'package:tripStory/presentation/trip/models/j_plan_state.dart';
import 'package:tripStory/presentation/trip/models/j_plan_swap_param.dart';
import 'package:tripStory/presentation/trip/widgets/j_plan_map_marker.dart';

class JPlanController extends GetxController {
  final TripRoomService _tripRoomService;
  final FetchJPlanUsecase _fetchJPlanUsecase;
  final DeleteJPlanUsecase _deleteJPlanUsecase;
  final MoveJPlanLockerUsecase _moveJPlanLockerUsecase;
  final JPlanSwapRegisterUsecase _jPlanSwapRegisterUsecase;
  final JPlanConnectSocketUsecase _jPlanConnectSocketUsecase;
  final JPlanListenSocketUsecase _jPlanListenSocketUsecase;
  final JPlanDisconnectSocketUsecase _disconnectSocketUsecase;
  final FetchFlightUsecase _fetchFlightUsecase;
  final DeleteFlightUsecase _deleteFlightUsecase;
  final MarkerIconService _markerIconService;

  JPlanController(
    this._tripRoomService,
    this._fetchJPlanUsecase,
    this._deleteJPlanUsecase,
    this._moveJPlanLockerUsecase,
    this._jPlanSwapRegisterUsecase,
    this._jPlanConnectSocketUsecase,
    this._jPlanListenSocketUsecase,
    this._disconnectSocketUsecase,
    this._fetchFlightUsecase,
    this._deleteFlightUsecase,
    this._markerIconService,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  JPlanState _jPlanState = JPlanState();

  JPlanState get state => _jPlanState;

  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  ScrollController dayScrollController = ScrollController();
  ScrollController listController = ScrollController();

  final minHeight = 154.0;
  final maxHeight = 300.0;
  double dayItemWidth = 48;
  Polyline? _cachedPolyline;
  final Map<String, Marker> _markerCache = {};
  final Map<String, int> _markerIndices = {};

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
      _getCurrentLocation(),
      _planSocketInit(),
      _getJPlanData(),
      _getFlight(),
    ]);
  }

  Future<void> _getJPlanData() async {
    final params = Tuple3(
      tripRoomInfo?.id ?? 0,
      tripRoomInfo?.dayAfterStartFrom(state.selectedDate ?? DateTime.now()) ?? 1,
      false,
    );

    final result = await _fetchJPlanUsecase.call(params);
    result.fold(
      (failure) {},
      (plans) async {
        _jPlanState = state.copyWith(
          plans: plans,
        );
        final (makers, polylines) = await _buildMarkersAndPolyLines(plans: plans);
        _jPlanState = state.copyWith(
          plans: plans,
          markers: makers,
          polylines: polylines,
        );
        update();
      },
    );
  }

  Future<void> _getCurrentLocation() async {
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

  Future<void> _planSocketInit() async {
    final tripId = tripRoomInfo?.id;
    if (tripId == null) return;

    final result = await _jPlanConnectSocketUsecase.call(tripId);

    result.fold((failure) {}, (success) {
      _jPlanListenSocketUsecase(tripId).listen((event) {
        switch (event) {
          case PlanAddedEntity(:final plan):
            _planAdd(plan);
            break;

          case PlanDeletedEntity(:final planId, :final dayAfterStart):
            _planDelete(planId, dayAfterStart);
            break;

          case PlanModifyEntity(:final plan):
            _planModify(plan);
            break;

          case PlanRegisterEntity():
            _planRegister();
            break;

          case PlanWaitEntity(:final day, :final nickname):
            _planWait(day, nickname);
            break;

          case PlanSwapEntity(:final dayAfterStart, :final planList):
            _planSwap(dayAfterStart, planList);
            break;
        }
      });
    });
  }

  Future<void> _getFlight() async {
    final tripId = tripRoomInfo?.id;
    if (tripId == null) return;
    final result = await _fetchFlightUsecase.call(tripId);

    result.fold(
      (failure) {},
      (flight) {
        _jPlanState = state.copyWith(
          flightEntity: flight,
        );
        update();
      },
    );
  }

  int _findInsertIndex(
    List<JPlanEntity> plans,
    JPlanEntity newPlan,
  ) {
    int left = 0;
    int right = plans.length;

    while (left < right) {
      int mid = (left + right) ~/ 2;
      if (plans[mid].startTime.compareTo(newPlan.startTime) <= 0) {
        left = mid + 1;
      } else {
        right = mid;
      }
    }
    return left;
  }

  Future<void> _planAdd(JPlanEntity plan) async {
    if (plan.dayAfterStart != state.selectedDay) return;

    final insertIndex = _findInsertIndex(state.plans, plan);
    final updatedPlans = [...state.plans];
    final updatedMarkers = <Marker>{...state.markers};
    final updatedPolyLines = <Polyline>{...state.polylines};
    updatedPlans.insert(insertIndex, plan);

    if (!plan.hasLocation) {
      _jPlanState = state.copyWith(plans: updatedPlans);
      update();
      return;
    }

    final (newMarkers, newPolylines) = await _buildMarkersAndPolyLines(
      plans: updatedPlans,
    );

    updatedMarkers.addAll(newMarkers);
    updatedPolyLines.addAll(newPolylines);

    _jPlanState = state.copyWith(
      plans: updatedPlans,
      markers: updatedMarkers,
      polylines: updatedPolyLines,
    );

    update();
  }

  Future<void> _planDelete(
    int planId,
    int dayAfterStart,
  ) async {
    if (dayAfterStart != state.selectedDay) return;

    final deleteIndex = state.plans.indexWhere((plan) => plan.planId == planId);
    final removedPlan = state.plans[deleteIndex];
    final updatedPlans = [...state.plans]..removeAt(deleteIndex);

    final removedCacheKey = "${tripRoomInfo?.id}_${removedPlan.dayAfterStart}_${removedPlan.planId}";
    _removeMarker(removedCacheKey);

    final (newMarkers, newPolylines) = await _buildMarkersAndPolyLines(
      plans: updatedPlans,
    );

    _jPlanState = state.copyWith(
      plans: updatedPlans,
      markers: newMarkers,
      polylines: newPolylines,
    );
    update();
  }

  Future<void> _planModify(JPlanEntity modifyPlan) async {
    if (modifyPlan.dayAfterStart != state.selectedDay) return;
    final modifyIndex = state.plans.indexWhere((plan) => plan.planId == modifyPlan.planId);
    final updatePlans = [...state.plans];
    updatePlans[modifyIndex] = modifyPlan;

    final (markers, polylines) = await _buildMarkersAndPolyLines(
      plans: updatePlans,
    );

    _jPlanState = state.copyWith(
      plans: updatePlans,
      markers: markers,
      polylines: polylines,
    );
    update();
  }

  void _planRegister() {
    final swapParams = state.plans.map(JPlanSwapParam.fromEntity).toList();
    Get.toNamed(
      Routes.tripJPlanSwap,
      arguments: swapParams,
    )?.then((value) {
      if (value) {
        _jPlanState = state.copyWith(
          showToast: OneTimeEvent("일정 순서 변경이 완료됐습니다"),
        );
        update();
      }
    });
  }

  void _planWait(
    int day,
    String name,
  ) {
    _jPlanState = state.copyWith(
      showToast: OneTimeEvent("$name님이 일정을 수정 중입니다"),
    );
    update();
  }

  void _planSwap(int dayAfterStart, List<JPlanEntity> plans) {
    _jPlanState = state.copyWith(
      plans: plans,
    );
    update();
  }

  /// 마커 관련 로직
  Future<(Set<Marker>, Set<Polyline>)> _buildMarkersAndPolyLines({
    required List<JPlanEntity> plans,
  }) async {
    final markerFutures = <Future<Marker>>[];
    final List<LatLng> polyLineLatLng = [];
    int markerIndex = 1;

    for (final plan in plans) {
      if (!plan.hasLocation) continue;

      markerFutures.add(
        _createdMarker(
          plan: plan,
          index: markerIndex,
        ),
      );

      polyLineLatLng.add(LatLng(plan.latitude ?? 0.0, plan.longitude ?? 0.0));
      markerIndex++;
    }

    final markers = (await Future.wait(markerFutures)).toSet();
    final polyLines = _createPolyline(polyLineLatLng);

    return (markers, polyLines);
  }

  Set<Polyline> _createPolyline(List<LatLng> points) {
    if (points.length < 2) {
      _cachedPolyline = null;
      return {};
    }

    final polylineId = PolylineId("trip_${tripRoomInfo?.id}_day_${state.selectedDay}");

    final polyline = _cachedPolyline?.copyWith(pointsParam: points) ??
        Polyline(
          polylineId: polylineId,
          points: points,
          color: Color(0xFF4C90FF),
          width: 3,
        );

    _cachedPolyline = polyline;

    return {polyline};
  }

  Future<Marker> _createdMarker({
    required JPlanEntity plan,
    required int index,
  }) async {
    final cacheKey = "${tripRoomInfo?.id}_${plan.dayAfterStart}_${plan.planId}";
    final existingMarker = _markerCache[cacheKey];
    final currentIndex = _markerIndices[cacheKey];
    final newPosition = LatLng(plan.latitude ?? 0.0, plan.longitude ?? 0.0);

    if (existingMarker != null) {
      final positionChanged = existingMarker.position != newPosition;
      final indexChanged = currentIndex != index;

      if (!positionChanged && !indexChanged) {
        return existingMarker;
      }

      Marker updatedMarker = existingMarker;

      if (indexChanged) {
        _markerIconService.removeCache(cacheKey);

        final icon = await _markerIconService.renderIconWithBuilder(
          cacheKey: cacheKey,
          widget: () => JPlanMapMarker(index: index),
        );
        updatedMarker = updatedMarker.copyWith(iconParam: icon);
        _markerIndices[cacheKey] = index;
      }

      if (positionChanged) {
        updatedMarker = updatedMarker.copyWith(positionParam: newPosition);
      }

      _markerCache[cacheKey] = updatedMarker;
      return updatedMarker;
    }

    final icon = await _markerIconService.renderIconWithBuilder(
      cacheKey: cacheKey,
      widget: () => JPlanMapMarker(index: index),
    );

    final marker = Marker(
      markerId: MarkerId(cacheKey),
      position: newPosition,
      icon: icon,
      onTap: () async => _mapCameraMove(newPosition),
    );

    _markerCache[cacheKey] = marker;
    _markerIndices[cacheKey] = index;

    return marker;
  }

  void _removeMarker(String markerKey) {
    final removedCacheKey = markerKey;
    _markerCache.remove(removedCacheKey);
    _markerIndices.remove(removedCacheKey);
    _markerIconService.removeCache(removedCacheKey);
  }

  Future<void> _mapCameraMove(LatLng movePosition) async {
    final controller = await mapController.future;
    final cameraPosition = CameraPosition(
      target: movePosition,
      zoom: 14,
    );
    await controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  /// sideEffect
  void onMapDrag(double detail) {
    double nextHeight = state.googleMapHeight + detail;
    if (nextHeight < minHeight) nextHeight = minHeight;
    if (nextHeight > maxHeight) nextHeight = maxHeight;

    _jPlanState = state.copyWith(googleMapHeight: nextHeight);
    update();
  }

  void onDayPressed(
    int index,
    DateTime? selectedDate,
  ) {
    double scrollOffset = dayItemWidth * index;

    dayScrollController.animateTo(
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

  void onFlightPressed() => Get.toNamed(Routes.searchFlight)?.then((flight) {
        if (flight != null) {
          _jPlanState = state.copyWith(
            flightEntity: flight,
          );
          update();
        }
      });

  Future<void> onFlightDeletedPressed() async {
    final params = Tuple2(
      tripRoomInfo?.id ?? 0,
      state.flightEntity?.flightId ?? 0,
    );
    final result = await _deleteFlightUsecase.call(params);

    result.fold(
      (failure) {},
      (success) {
        _jPlanState = state.copyWith(
          flightEntity: null,
        );
        update();
        RouteHelper.closeAllOverlays();
      },
    );
  }

  Future<void> onPlanSwapPressed() async {
    final tripId = tripRoomInfo?.id;
    final day = state.selectedDay;
    if (tripId == null) return;

    await _jPlanSwapRegisterUsecase.call(
      Tuple2(tripId, day),
    );
  }

  void onAddPlanPressed() {
    Get.toNamed(
      Routes.tripJPlanAdd,
      arguments: state.selectedDate,
    );
  }

  void onEditPlanPressed(JPlanEntity jPlan) {
    Get.toNamed(
      Routes.tripJPlanEdit,
      arguments: JPlanEditParams(
        selectedDate: state.selectedDate ?? DateTime.now(),
        jPlan: jPlan,
      ),
    );
  }

  Future<void> onPlanDeletePressed(
    int planId,
  ) async {
    final params = Tuple3(
      tripRoomInfo?.id ?? 0,
      planId,
      tripRoomInfo?.dayAfterStartFrom(state.selectedDate ?? DateTime.now()) ?? 1,
    );

    final result = await _deleteJPlanUsecase.call(params);

    result.fold(
      (failure) {},
      (success) {
        update();
      },
    );
  }

  Future<void> onMoveToLockerPressed(
    JPlanEntity plan,
  ) async {
    final params = Tuple2(
      tripRoomInfo?.id ?? 0,
      plan,
    );
    await _moveJPlanLockerUsecase.call(params);
  }

  @override
  void onClose() {
    _disconnectSocketUsecase.call(NoParams());
    dayScrollController.dispose();
    super.onClose();
  }
}
