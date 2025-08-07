import 'package:get/get.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';

class TripRoomService extends GetxService {
  TripRoomEntity? _tripRoomEntity;

  TripRoomEntity? get tripRoomEntity => _tripRoomEntity;

  void setTripRoom(TripRoomEntity room) {
    _tripRoomEntity = room;
  }

  void clear() {
    _tripRoomEntity = null;
  }
}
