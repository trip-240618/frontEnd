// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserResponse _$UserResponseFromJson(Map<String, dynamic> json) =>
    _UserResponse(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      nickName: json['nickName'] as String,
      memo: json['memo'] as String,
      thumbnail: json['thumbnail'] as String,
      profileImg: json['profileImg'] as String,
      type: json['type'] as String,
      createDate: json['createDate'] as String,
    );

Map<String, dynamic> _$UserResponseToJson(_UserResponse instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'nickName': instance.nickName,
      'memo': instance.memo,
      'thumbnail': instance.thumbnail,
      'profileImg': instance.profileImg,
      'type': instance.type,
      'createDate': instance.createDate,
    };
