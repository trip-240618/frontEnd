import 'package:get/get.dart';
import 'package:tripStory/core/util/extension/date_extension.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/edit_j_plan_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/j_plan_editor_state.dart';

class JPlanEditController extends GetxController {
  final TripRoomService _tripRoomService;
  final EditJPlanUsecase _editJPlanUsecase;

  JPlanEditController(
    this._tripRoomService,
    this._editJPlanUsecase,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  Future<void> onEditSavePressed(
    int? planId,
    JPlanEditorState state,
  ) async {
    if (planId == null) return;

    final editJPlanParams = EditJPlanParams(
      tripId: tripRoomInfo?.id ?? 0,
      planId: planId,
      dayAfterStart: tripRoomInfo?.dayAfterStartFrom(state.selectedDate ?? DateTime.now()) ?? 1,
      startTime: state.selectedTime?.formatTime ?? "",
      title: state.planTitle,
      latitude: state.searchLatitude,
      longitude: state.searchLongitude,
      memo: state.planMemo,
      place: state.searchPlace?.formattedAddress,
      locker: false,
    );

    final result = await _editJPlanUsecase.call(editJPlanParams);

    result.fold(
      (failure) {},
      (success) {
        Get.back();
      },
    );
  }
}
