// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationsResponse _$NotificationsResponseFromJson(
        Map<String, dynamic> json) =>
    _NotificationsResponse(
      id: (json['id'] as num).toInt(),
      labelColor: json['labelColor'] as String,
      destination: json['destination'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createDate: json['createDate'] as String,
      read: json['read'] as bool,
    );

Map<String, dynamic> _$NotificationsResponseToJson(
        _NotificationsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'labelColor': instance.labelColor,
      'destination': instance.destination,
      'title': instance.title,
      'content': instance.content,
      'createDate': instance.createDate,
      'read': instance.read,
    };
