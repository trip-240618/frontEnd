// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uuid: json['uuid'] as String,
      name: json['name'] as String?,
      nickName: json['nickName'] as String?,
      memo: json['memo'] as String?,
      thumbnail: json['thumbnail'] as String?,
      profileImg: json['profileImg'] as String?,
      type: json['type'] as String?,
      createDate: json['createDate'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'nickName': instance.nickName,
      'memo': instance.memo,
      'thumbnail': instance.thumbnail,
      'profileImg': instance.profileImg,
      'type': instance.type,
      'createDate': instance.createDate,
    };
