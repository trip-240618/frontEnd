import 'package:get/get.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/domain/entities/location_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/router/routes.dart';
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

  void onPlanTitleChanged(String text) {
    _jPlanAddState = state.copyWith(
      planTitle: text,
    );
    update();
  }

  void onPlanMemoChanged(String text) {
    _jPlanAddState = state.copyWith(
      planMemo: text,
    );
    update();
  }

  void onLocationPressed() {
    Get.toNamed(Routes.locationSearch)?.then((value) {
      if (value is LocationEntity) {
        _jPlanAddState = state.copyWith(
          searchPlace: value,
        );
        update();
      }
    });
  }

  void onLocationDeletePressed() {
    Get.toNamed(Routes.locationSearch)?.then((value) {
      if (value is LocationEntity) {
        _jPlanAddState = state.copyWith(
          searchPlace: value,
        );
        update();
      }
    });
  }
}
