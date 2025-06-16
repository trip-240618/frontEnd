import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_room_entity.freezed.dart';

@freezed
abstract class TripRoomEntity with _$TripRoomEntity {
  const TripRoomEntity._();

  const factory TripRoomEntity({
    required int id,
    required String name,
    required String type,
    required DateTime startDate,
    required DateTime endDate,
    required String country,
    String? thumbnail,
    required String invitationCode,
    required String labelColor,
    required bool bookmark,
    required String domain,
    required List<TripMemberEntity> members,
  }) = _TripRoomEntity;

  int get memberCount => members.length;

  int get dDay => startDate.difference(DateTime.now()).inDays + 1;
}

@freezed
abstract class TripMemberEntity with _$TripMemberEntity {
  const factory TripMemberEntity({
    required String uuid,
    required String nickname,
    String? thumbnail,
    required bool leader,
  }) = _TripMemberEntity;
}
