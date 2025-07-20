import 'package:get/get.dart';
import 'package:tripStory/core/services/socket_service.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/view/trip/models/trip_main_state.dart';

class TripMainController extends GetxController {
  final TripRoomService _tripRoomService;
  final SocketService _socketService;

  TripMainController(
    this._tripRoomService,
    this._socketService,
  );

  TripMainState _tripMainState = TripMainState();

  TripMainState get state => _tripMainState;

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  @override
  void onInit() {
    super.onInit();
    _socketService.connect(
      tripId: tripRoomInfo?.id ?? 0,
    );
  }

  void onNaviPressed(int index) {
    _tripMainState = state.copyWith(
      selectedTripType: TripNaviType.values[index],
    );
    update();
  }
}
