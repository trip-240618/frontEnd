// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_room_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripRoomCreateRequest _$TripRoomCreateRequestFromJson(
        Map<String, dynamic> json) =>
    _TripRoomCreateRequest(
      name: json['name'] as String,
      type: json['type'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      country: json['country'] as String,
      thumbnail: json['thumbnail'] as String,
      labelColor: json['labelColor'] as String,
    );

Map<String, dynamic> _$TripRoomCreateRequestToJson(
        _TripRoomCreateRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'country': instance.country,
      'thumbnail': instance.thumbnail,
      'labelColor': instance.labelColor,
    };
