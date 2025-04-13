// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albumModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumModel _$AlbumModelFromJson(Map<String, dynamic> json) => AlbumModel(
      id: json['id'] as String,
      name: json['name'] as String,
      images: json['images'] as List<dynamic>,
    );

Map<String, dynamic> _$AlbumModelToJson(AlbumModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': instance.images,
    };
