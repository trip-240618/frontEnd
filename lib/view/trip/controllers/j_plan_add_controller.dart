import 'package:get/get.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/view/trip/models/j_plan_add_state.dart';

class JPlanAddController extends GetxController {
  final TripRoomService _tripRoomService;

  JPlanAddController(
    this._tripRoomService,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  JPlanAddState _jPlanAddState = JPlanAddState();

  JPlanAddState get state => _jPlanAddState;

  void init(
    DateTime selectedDate,
  ) {
    _jPlanAddState = state.copyWith(
      selectedDate: selectedDate,
      selectedTime: selectedDate,
    );
  }

  void onDateChanged(
    DateTime selectedDate,
  ) {
    _jPlanAddState = state.copyWith(
      selectedDate: selectedDate,
    );
    update();
  }

  void onTimeChanged(
    DateTime selectedTime,
  ) {
    _jPlanAddState = state.copyWith(
      selectedTime: selectedTime,
    );
    update();
  }
}
