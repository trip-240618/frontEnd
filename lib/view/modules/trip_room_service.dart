import 'package:get/get.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';

class TripRoomService extends GetxController {
  final Rxn<TripRoomEntity> tripRoom = Rxn<TripRoomEntity>();

  TripRoomEntity? get tripRoomEntity => tripRoom.value;

  void setTripRoom(TripRoomEntity room) {
    tripRoom.value = room;
  }

  void clear() {
    tripRoom.value = null;
  }
}
