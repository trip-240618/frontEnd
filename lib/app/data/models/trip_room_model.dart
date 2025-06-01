import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_room_model.freezed.dart';
part 'trip_room_model.g.dart';

@freezed
abstract class TripRoomModel with _$TripRoomModel {
  const factory TripRoomModel({
    required int id,
    required String name,
    required String type,
    required String startDate,
    required String endDate,
    required String country,
    required String thumbnail,
    required String invitationCode,
    required String labelColor,
    required bool bookmark,
    required String domain,
    required List<TripMember> tripMemberDtoList,
  }) = _TripRoomModel;

  factory TripRoomModel.fromJson(Map<String, dynamic> json) => _$TripRoomModelFromJson(json);
}

@freezed
abstract class TripMember with _$TripMember {
  const factory TripMember({
    required String uuid,
    required String nickname,
    required String thumbnail,
    required bool leader,
  }) = _TripMember;

  factory TripMember.fromJson(Map<String, dynamic> json) => _$TripMemberFromJson(json);
}
