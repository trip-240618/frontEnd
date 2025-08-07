import 'package:get/get.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/models/flight_search_state.dart';

class FlightSearchController extends GetxController {
  final TripRoomService _tripRoomService;

  FlightSearchController(
    this._tripRoomService,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  FlightSearchState _flightSearchState = FlightSearchState();

  FlightSearchState get state => _flightSearchState;
}
