import 'package:get/get.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';

class TripRoomService extends GetxController {
  final Rxn<TripRoomEntity> tripRoom = Rxn<TripRoomEntity>();

  TripRoomEntity? get tripRoomEntity => tripRoom.value;
  
  void removeMember(String uuid) {
    final room = tripRoom.value;
    if (room == null) return;

    final updatedMembers = room.members.where((member) => member.uuid != uuid).toList(growable: false);

    if (updatedMembers.length == room.members.length) return;

    tripRoom.value = room.copyWith(
      members: updatedMembers,
    );
  }

  void setTripRoom(TripRoomEntity room) {
    tripRoom.value = room;
  }

  void clear() {
    tripRoom.value = null;
  }
}
