// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_room_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripRoomCreateResponse _$TripRoomCreateResponseFromJson(
        Map<String, dynamic> json) =>
    _TripRoomCreateResponse(
      tripId: (json['tripId'] as num).toInt(),
      invitationCode: json['invitationCode'] as String,
    );

Map<String, dynamic> _$TripRoomCreateResponseToJson(
        _TripRoomCreateResponse instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'invitationCode': instance.invitationCode,
    };
