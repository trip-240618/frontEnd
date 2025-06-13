import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_room_create_request.freezed.dart';
part 'trip_room_create_request.g.dart';

@freezed
abstract class TripRoomCreateRequest with _$TripRoomCreateRequest {
  const factory TripRoomCreateRequest({
    required String name,
    required String type,
    required String startDate,
    required String endDate,
    required String country,
    required String thumbnail,
    required String labelColor,
  }) = _TripRoomCreateRequest;

  factory TripRoomCreateRequest.fromJson(Map<String, dynamic> json) => _$TripRoomCreateRequestFromJson(json);
}
