import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/data/models/request/plan_j_create_request.dart';
import 'package:tripStory/domain/entities/location_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/create_j_plan_usecase.dart';
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/util/extension/date_extension.dart';
import 'package:tripStory/view/trip/models/j_plan_create_state.dart';

class JPlanCreateController extends GetxController {
  final TripRoomService _tripRoomService;
  final CreateJPlanUsecase _createJPlanUsecase;

  JPlanCreateController(
    this._tripRoomService,
    this._createJPlanUsecase,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  JPlanCreateState _jPlanAddState = JPlanCreateState();

  JPlanCreateState get state => _jPlanAddState;

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
    _jPlanAddState = state.copyWith(
      searchPlace: null,
    );
    update();
  }

  Future<void> onPlanSavePressed() async {
    final tripRoomCreateRequest = PlanJCreateRequest(
      dayAfterStart: tripRoomInfo?.dayAfterStartFrom(state.selectedDate ?? DateTime.now()) ?? 1,
      startTime: state.selectedTime?.formatTime ?? "",
      title: state.planTitle,
      place: state.searchPlace?.displayName ?? "",
      memo: state.planMemo,
      latitude: state.searchLatitude,
      longitude: state.searchLongitude,
      locker: false,
    );
    final params = Tuple2(
      tripRoomInfo?.id ?? 0,
      tripRoomCreateRequest,
    );

    final result = await _createJPlanUsecase.call(params);

    result.fold(
      (failure) {},
      (success) {
        Get.back();
      },
    );
  }
}
