// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppleLoginRequest _$AppleLoginRequestFromJson(Map<String, dynamic> json) =>
    _AppleLoginRequest(
      email: json['email'] as String?,
      familyName: json['familyName'] as String?,
      givenName: json['givenName'] as String?,
      identityToken: json['identityToken'] as String,
      state: json['state'] as String,
      userIdentifier: json['userIdentifier'] as String,
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$AppleLoginRequestToJson(_AppleLoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'familyName': instance.familyName,
      'givenName': instance.givenName,
      'identityToken': instance.identityToken,
      'state': instance.state,
      'userIdentifier': instance.userIdentifier,
      'fcmToken': instance.fcmToken,
    };
