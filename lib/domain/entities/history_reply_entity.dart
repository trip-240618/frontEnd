import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_reply_entity.freezed.dart';

@freezed
abstract class HistoryReplyEntity with _$HistoryReplyEntity {
  const HistoryReplyEntity._();

  const factory HistoryReplyEntity({
    required int id,
    required String writerUuid,
    required String profileImage,
    required String nickname,
    required DateTime createDate,
    required DateTime modifiedDate,
    required String content,
  }) = _HistoryReplyEntity;
}
