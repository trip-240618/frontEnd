import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_room_model.freezed.dart';
part 'trip_room_model.g.dart';

@freezed
abstract class TripRoomModel with _$TripRoomModel {
  const TripRoomModel._();

  const factory TripRoomModel({
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
  }) = _TripRoomModel;

  int get memberLength => tripMemberDtoList.length;

  factory TripRoomModel.fromJson(Map<String, dynamic> json) => _$TripRoomModelFromJson(json);
}

extension TripRoomModelExtension on TripRoomModel {
  bool get isOnTrip {
    final start = DateTime.parse(startDate);
    final end = DateTime.parse(endDate);
    final now = DateTime.now();
    return now.isAfter(start) && now.isBefore(end);
  }

  String get dDayText {
    final start = DateTime.parse(startDate);
    final days = start.difference(DateTime.now()).inDays + 1;
    return days < 1 ? '여행중' : 'D-$days';
  }

  int get longestNicknameLength => tripMemberDtoList.map((e) => e.nickname.length).fold(0, (a, b) => a > b ? a : b);
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
