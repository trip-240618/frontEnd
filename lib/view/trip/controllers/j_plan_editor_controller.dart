import 'package:get/get.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/domain/entities/location_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/view/trip/models/j_plan_editor_state.dart';

class JPlanEditorController extends GetxController {
  final TripRoomService _tripRoomService;

  JPlanEditorController(
    this._tripRoomService,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  JPlanEditorState _jPlanEditorState = JPlanEditorState();

  JPlanEditorState get state => _jPlanEditorState;

  void initForCreate({
    required DateTime selectedDate,
  }) {
    _jPlanEditorState = JPlanEditorState(
      selectedDate: selectedDate,
      selectedTime: selectedDate,
    );
    update();
  }

  void initForEdit({
    required DateTime selectedDate,
    String? title,
    String? memo,
    DateTime? time,
    String? place,
    double? latitude,
    double? longitude,
  }) {
    final hasPlace = place?.isNotEmpty == true;

    _jPlanEditorState = _jPlanEditorState.copyWith(
      selectedDate: selectedDate,
      selectedTime: time,
      planTitle: title ?? "",
      planMemo: memo ?? "",
      searchPlace: hasPlace
          ? LocationEntity(
              displayName: place ?? "",
              formattedAddress: place ?? "",
              latitude: latitude ?? 0.0,
              longitude: longitude ?? 0.0,
            )
          : null,
    );
    update();
  }

  void onDateChanged(
    DateTime selectedDate,
  ) {
    _jPlanEditorState = state.copyWith(
      selectedDate: selectedDate,
    );
    update();
  }

  void onTimeChanged(
    DateTime selectedTime,
  ) {
    _jPlanEditorState = state.copyWith(
      selectedTime: selectedTime,
    );
    update();
  }

  void onPlanTitleChanged(String text) {
    _jPlanEditorState = state.copyWith(
      planTitle: text,
    );
    update();
  }

  void onPlanMemoChanged(String text) {
    _jPlanEditorState = state.copyWith(
      planMemo: text,
    );
    update();
  }

  void onLocationPressed() {
    Get.toNamed(Routes.locationSearch)?.then((value) {
      if (value is LocationEntity) {
        _jPlanEditorState = state.copyWith(
          searchPlace: value,
        );
        update();
      }
    });
  }

  void onLocationDeletePressed() {
    _jPlanEditorState = state.copyWith(
      searchPlace: null,
    );
    update();
  }
}
