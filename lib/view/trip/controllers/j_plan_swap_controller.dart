import 'package:get/get.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/models/j_plan_swap_param.dart';
import 'package:tripStory/view/trip/models/j_plan_swap_state.dart';

class JPlanSwapController extends GetxController {
  final TripRoomService _tripRoomService;

  JPlanSwapController(
    this._tripRoomService,
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
}
