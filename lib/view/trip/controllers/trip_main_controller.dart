import 'package:get/get.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/view/trip/models/trip_main_state.dart';

class TripMainController extends GetxController {
  final TripRoomService _tripRoomService;

  TripMainController(
    this._tripRoomService,
  );

  TripMainState _tripMainState = TripMainState();

  TripMainState get state => _tripMainState;

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  void onNaviPressed(int index) {
    _tripMainState = state.copyWith(
      selectedTripType: TripNaviType.values[index],
    );
    update();
  }
}
