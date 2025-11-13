import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_room_modify_request.freezed.dart';
part 'trip_room_modify_request.g.dart';

@freezed
abstract class TripRoomModifyRequest with _$TripRoomModifyRequest {
  const factory TripRoomModifyRequest({
    required String name,
    String? thumbnail,
    required String labelColor,
    required String startDate,
    required String endDate,
  }) = _TripRoomModifyRequest;

  factory TripRoomModifyRequest.fromJson(Map<String, dynamic> json) => _$TripRoomModifyRequestFromJson(json);
}
