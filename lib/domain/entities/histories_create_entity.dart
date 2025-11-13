import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/tag_entity.dart';

part 'histories_create_entity.freezed.dart';
part 'histories_create_entity.g.dart';

@freezed
abstract class HistoriesCreateEntity with _$HistoriesCreateEntity {
  const factory HistoriesCreateEntity({
    required int tripId,
    required List<HistoryUploadEntity> historyItems,
  }) = _HistoriesCreateEntity;

  factory HistoriesCreateEntity.fromJson(Map<String, dynamic> json) => _$HistoriesCreateEntityFromJson(json);
}

@freezed
abstract class HistoryUploadEntity with _$HistoryUploadEntity {
  const factory HistoryUploadEntity({
    String? thumbnail,
    String? imageUrl,
    double? latitude,
    double? longitude,
    String? photoDate,
    String? memo,
    List<TagEntity>? tags,
  }) = _HistoryUploadEntity;

  factory HistoryUploadEntity.fromJson(Map<String, dynamic> json) => _$HistoryUploadEntityFromJson(json);
}
