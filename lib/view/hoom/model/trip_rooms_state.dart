import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:tripStory/app/data/models/trip_room.dart';
import 'package:tripStory/view/hoom/enum/trip_rooms_type.dart';

part 'trip_rooms_state.freezed.dart';

@freezed
abstract class TripRoomsState with _$TripRoomsState {
  const TripRoomsState._();

  const factory TripRoomsState({
    @Default([]) List<TripRoom> tripRooms,
    @Default(TripRoomType.coming) TripRoomType tripRoomType,
  }) = _TripRoomsState;

  int get tripListLength => tripRooms.length;

  bool get isTripRoomEmpty => tripRooms.isEmpty;

  TripRoom? findTripRoom(int tripId) => tripRooms.firstWhereOrNull((room) => room.id == tripId);
}
