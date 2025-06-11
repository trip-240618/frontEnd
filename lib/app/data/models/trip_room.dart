import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_room.freezed.dart';
part 'trip_room.g.dart';

@freezed
abstract class TripRoom with _$TripRoom {
  const TripRoom._();

  const factory TripRoom({
    required int id,
    required String name,
    required String type,
    required String startDate,
    required String endDate,
    required String country,
    String? thumbnail,
    required String invitationCode,
    required String labelColor,
    required bool bookmark,
    required String domain,
    required List<TripMember> tripMemberDtoList,
  }) = _TripRoom;

  int get memberLength => tripMemberDtoList.length;

  int get dDay {
    final start = DateTime.tryParse(startDate);
    if (start == null) return -9999;
    return start.difference(DateTime.now()).inDays + 1;
  }

  factory TripRoom.fromJson(Map<String, dynamic> json) => _$TripRoomFromJson(json);
}

@freezed
abstract class TripMember with _$TripMember {
  const factory TripMember({
    required String uuid,
    required String nickname,
    String? thumbnail,
    required bool leader,
  }) = _TripMember;

  factory TripMember.fromJson(Map<String, dynamic> json) => _$TripMemberFromJson(json);
}
