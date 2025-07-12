// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserRequest _$UserRequestFromJson(Map<String, dynamic> json) => _UserRequest(
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      id: json['id'] as String,
      photoUrl: json['photoUrl'] as String,
      serverAuthCode: json['serverAuthCode'] as String?,
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$UserRequestToJson(_UserRequest instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'id': instance.id,
      'photoUrl': instance.photoUrl,
      'serverAuthCode': instance.serverAuthCode,
      'fcmToken': instance.fcmToken,
    };
