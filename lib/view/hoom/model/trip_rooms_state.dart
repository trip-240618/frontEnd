import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/view/hoom/enum/trip_rooms_type.dart';

part 'trip_rooms_state.freezed.dart';

enum TripRoomsStatus { initial, loading, success, failure, empty }

@freezed
abstract class TripRoomsState with _$TripRoomsState {
  const TripRoomsState._();

  const factory TripRoomsState({
    @Default(TripRoomsStatus.initial) TripRoomsStatus tripRoomsStatus,
    @Default([]) List<TripRoomEntity> tripRooms,
    @Default(TripRoomType.coming) TripRoomType tripRoomType,
  }) = _TripRoomsState;

  int get tripListLength => tripRooms.length;

  bool get isTripRoomEmpty => tripRooms.isEmpty;

  TripRoomEntity? findTripRoom(int tripId) => tripRooms.firstWhereOrNull((room) => room.id == tripId);
}
