import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/tag_entity.dart';

part 'histories_entity.freezed.dart';
part 'histories_entity.g.dart';

@freezed
abstract class HistoriesEntity with _$HistoriesEntity {
  const HistoriesEntity._();

  const factory HistoriesEntity({
    required String photoDate,
    required List<HistoryEntity> historyList,
  }) = _HistoriesEntity;

  factory HistoriesEntity.fromJson(Map<String, dynamic> json) => _$HistoriesEntityFromJson(json);

  String get displayPhotoDate => photoDate.replaceAll("-", ".");

  List<int> idsForDate(String targetDate) {
    if (photoDate != targetDate) return [];
    return historyList.map((entity) => entity.id).toList();
  }
}

@freezed
abstract class HistoryEntity with _$HistoryEntity {
  const HistoryEntity._();

  const factory HistoryEntity({
    required int id,
    required String writerUuid,
    required String nickname,
    String? profileImage,
    required String thumbnail,
    required String imageUrl,
    double? latitude,
    double? longitude,
    String? memo,
    bool? like,
    int? likeCnt,
    int? replyCnt,
    DateTime? photoDate,
    List<TagEntity>? tags,
  }) = _HistoryEntity;

  factory HistoryEntity.fromJson(Map<String, dynamic> json) => _$HistoryEntityFromJson(json);

  bool get isValidLocation => latitude != null && longitude != null && latitude != 0.0 && longitude != 0.0;

  bool isWriter(String myUuid) => writerUuid == myUuid;
}
