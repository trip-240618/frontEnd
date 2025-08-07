import 'package:get/get.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';

class FlightCreateController extends GetxController {
  final TripRoomService _tripRoomService;

  FlightCreateController(
    this._tripRoomService,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;
}
