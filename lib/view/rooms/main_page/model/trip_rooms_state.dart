import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:tripStory/app/data/models/trip_room_model.dart';

part 'trip_rooms_state.freezed.dart';

@freezed
abstract class TripRoomsState with _$TripRoomsState {
  const TripRoomsState._();

  const factory TripRoomsState({
    @Default([]) List<TripRoomModel> tripRooms,
  }) = _TripRoomsState;

  int get tripListLength => tripRooms.length;

  bool get isTripRoomEmpty => tripRooms.isEmpty;

  TripRoomModel? findTripRoom(int tripId) => tripRooms.firstWhereOrNull((room) => room.id == tripId);
}
