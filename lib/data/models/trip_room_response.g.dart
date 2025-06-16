// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_room_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripRoomResponse _$TripRoomResponseFromJson(Map<String, dynamic> json) =>
    _TripRoomResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      country: json['country'] as String,
      thumbnail: json['thumbnail'] as String?,
      invitationCode: json['invitationCode'] as String,
      labelColor: json['labelColor'] as String,
      bookmark: json['bookmark'] as bool,
      domain: json['domain'] as String,
      tripMemberDtoList: (json['tripMemberDtoList'] as List<dynamic>)
          .map((e) => TripMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripRoomResponseToJson(_TripRoomResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'country': instance.country,
      'thumbnail': instance.thumbnail,
      'invitationCode': instance.invitationCode,
      'labelColor': instance.labelColor,
      'bookmark': instance.bookmark,
      'domain': instance.domain,
      'tripMemberDtoList': instance.tripMemberDtoList,
    };

_TripMember _$TripMemberFromJson(Map<String, dynamic> json) => _TripMember(
      uuid: json['uuid'] as String,
      nickname: json['nickname'] as String,
      thumbnail: json['thumbnail'] as String?,
      leader: json['leader'] as bool,
    );

Map<String, dynamic> _$TripMemberToJson(_TripMember instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'nickname': instance.nickname,
      'thumbnail': instance.thumbnail,
      'leader': instance.leader,
    };
