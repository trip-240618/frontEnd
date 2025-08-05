import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/domain/entities/j_plan_swap_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/j_plan_register_finish_usecase.dart';
import 'package:tripStory/domain/usecases/j_plan_swap_usecase.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/models/j_plan_swap_param.dart';
import 'package:tripStory/view/trip/models/j_plan_swap_state.dart';

class JPlanSwapController extends GetxController {
  final TripRoomService _tripRoomService;
  final JPlanSwapUsecase _jPlanSwapUsecase;
  final JPlanRegisterFinishUsecase _jPlanRegisterFinishUsecase;

  JPlanSwapController(
    this._tripRoomService,
    this._jPlanSwapUsecase,
    this._jPlanRegisterFinishUsecase,
  );

  JPlanSwapState _jPlanSwapState = JPlanSwapState();

  JPlanSwapState get state => _jPlanSwapState;

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  void init(List<JPlanSwapParam> params) {
    super.onInit();

    _jPlanSwapState = state.copyWith(
      plans: params,
    );
  }

  void onSwapPlanPressed(int tapIndex) {
    final tapped = state.plans[tapIndex];
    final selected = state.selectedPlan;

    if (selected == null) {
      _jPlanSwapState = state.copyWith(selectedPlan: tapped);
      update();
      return;
    }

    if (selected.planId == tapped.planId) {
      _jPlanSwapState = state.copyWith(selectedPlan: null);
      update();
      return;
    }

    final currentPlans = [...state.plans];
    final selectedIndex = currentPlans.indexWhere((p) => p.planId == selected.planId);

    if (selectedIndex == -1) return;

    final tappedPlan = currentPlans[tapIndex];
    final selectedPlan = currentPlans[selectedIndex];

    currentPlans[selectedIndex] = tappedPlan.copyWith(
      startTime: selectedPlan.startTime,
      orderByDate: selectedPlan.orderByDate,
    );

    currentPlans[tapIndex] = selectedPlan.copyWith(
      startTime: tappedPlan.startTime,
      orderByDate: tappedPlan.orderByDate,
    );

    _jPlanSwapState = state.copyWith(
      plans: currentPlans,
      selectedPlan: null,
    );

    update();
  }

  Future<void> onSwapSavePressed() async {
    final tripId = tripRoomInfo?.id ?? 0;
    final dayAfterStart = state.plans.firstOrNull?.dayAfterStart;
    final plans = state.plans;

    final entity = JPlanSwapEntity(
      dayAfterStart: dayAfterStart ?? 1,
      orderList: plans
          .map((plan) => JPlanSwapOrderEntity(
                planId: plan.planId,
                startTime: plan.startTime,
                orderByDate: plan.orderByDate,
              ))
          .toList(),
    );

    final result = await _jPlanSwapUsecase.call(Tuple2(tripId, entity));

    await result.fold(
      (failure) {},
      (success) async {
        _navigateToBack(tripId, dayAfterStart ?? 1, showToast: true);
      },
    );
  }

  Future<void> onBackButtonPressed() async {
    final tripId = tripRoomInfo?.id ?? 0;
    final dayAfterStart = state.plans.firstOrNull?.dayAfterStart;
    if (dayAfterStart == null) return;

    await _navigateToBack(tripId, dayAfterStart, closeOverlays: true);
  }

  Future<void> _navigateToBack(
    int tripId,
    int dayAfterStart, {
    bool closeOverlays = false,
    bool showToast = false,
  }) async {
    final result = await _jPlanRegisterFinishUsecase.call(Tuple2(tripId, dayAfterStart));
    result.fold(
      (failure) {},
      (success) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.back(result: showToast, closeOverlays: closeOverlays);
        });
      },
    );
  }
}
