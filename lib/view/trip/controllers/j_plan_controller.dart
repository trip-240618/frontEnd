import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/util/helper/route_helper.dart';
import 'package:tripStory/util/one_time_event.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/models/j_plan_edit_param.dart';
import 'package:tripStory/view/trip/models/j_plan_state.dart';
import 'package:tripStory/view/trip/models/j_plan_swap_param.dart';

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
      (plans) {
        _jPlanState = state.copyWith(
          plans: plans,
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

  void _planAdd(
    JPlanEntity plan,
  ) {
    if (plan.dayAfterStart != state.selectedDay) return;

    final updatedPlans = [...state.plans, plan];

    updatedPlans.sort((firstPlan, secondPlan) => firstPlan.startTime.compareTo(secondPlan.startTime));

    _jPlanState = state.copyWith(
      plans: updatedPlans,
    );

    update();
  }

  void _planDelete(
    int planId,
    int dayAfterStart,
  ) {
    if (dayAfterStart != state.selectedDay) return;

    _jPlanState = state.copyWith(
      plans: state.plans.where((p) => p.planId != planId).toList(),
    );

    update();
  }

  void _planModify(JPlanEntity plan) {}

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
