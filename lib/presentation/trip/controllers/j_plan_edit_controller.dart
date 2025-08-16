import 'package:get/get.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/j_plan_editor_state.dart';

class JPlanEditController extends GetxController {
  final TripRoomService _tripRoomService;

  JPlanEditController(
    this._tripRoomService,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  Future<void> onEditSavePressed(JPlanEditorState state) async {
    // final tripRoomCreateRequest = PlanJCreateRequest(
    //   dayAfterStart: tripRoomInfo?.dayAfterStartFrom(state.selectedDate ?? DateTime.now()) ?? 1,
    //   startTime: state.selectedTime?.formatTime ?? "",
    //   title: state.planTitle,
    //   place: state.searchPlace?.displayName ?? "",
    //   memo: state.planMemo,
    //   latitude: state.searchLatitude,
    //   longitude: state.searchLongitude,
    //   locker: false,
    // );
    // final params = Tuple2(
    //   tripRoomInfo?.id ?? 0,
    //   tripRoomCreateRequest,
    // );
    //
    // final result = await _createJPlanUsecase.call(params);
    //
    // result.fold(
    //   (failure) {},
    //   (success) {
    //     Get.back();
    //   },
    // );
  }
}
