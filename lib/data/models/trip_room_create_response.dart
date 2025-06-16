import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_room_create_response.freezed.dart';
part 'trip_room_create_response.g.dart';

@freezed
abstract class TripRoomCreateResponse with _$TripRoomCreateResponse {
  const factory TripRoomCreateResponse({
    required int tripId,
    required String invitationCode,
  }) = _TripRoomCreateResponse;

  factory TripRoomCreateResponse.fromJson(Map<String, dynamic> json) => _$TripRoomCreateResponseFromJson(json);
}
