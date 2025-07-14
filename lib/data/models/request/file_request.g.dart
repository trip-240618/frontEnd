// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FileRequest _$FileRequestFromJson(Map<String, dynamic> json) => _FileRequest(
      prefix: json['prefix'] as String,
      photoCnt: (json['photoCnt'] as num).toInt(),
    );

Map<String, dynamic> _$FileRequestToJson(_FileRequest instance) =>
    <String, dynamic>{
      'prefix': instance.prefix,
      'photoCnt': instance.photoCnt,
    };
