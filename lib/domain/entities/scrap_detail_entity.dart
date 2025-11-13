import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/data/models/response/scrap_detail_response.dart';

part 'scrap_detail_entity.freezed.dart';
part 'scrap_detail_entity.g.dart';

@freezed
abstract class ScrapDetailEntity with _$ScrapDetailEntity {
  const factory ScrapDetailEntity({
    required int id,
    required String writerUuid,
    required String nickname,
    required String title,
    required String content,
    required bool hasImage,
    required String color,
    required bool bookmark,
    required DateTime createDate,
    required List<ScrapImages> imageDtos,
  }) = _ScrapDetailEntity;

  factory ScrapDetailEntity.fromJson(Map<String, dynamic> json) => _$ScrapDetailEntityFromJson(json);
}
