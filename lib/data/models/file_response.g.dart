// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FileResponse _$FileResponseFromJson(Map<String, dynamic> json) =>
    _FileResponse(
      preSignedUrls: (json['preSignedUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FileResponseToJson(_FileResponse instance) =>
    <String, dynamic>{
      'preSignedUrls': instance.preSignedUrls,
    };
