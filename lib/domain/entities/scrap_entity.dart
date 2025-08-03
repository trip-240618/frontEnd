import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrap_entity.freezed.dart';

@freezed
abstract class ScrapEntity with _$ScrapEntity {
  const ScrapEntity._();

  const factory ScrapEntity({
    required int id,
    required String writerUuid,
    required String nickname,
    required String title,
    required String preview,
    required bool hasImage,
    required String color,
    required bool bookmark,
    required DateTime createDate,
  }) = _ScrapEntity;

  bool isMine(String myUuid) => writerUuid == myUuid;
}
