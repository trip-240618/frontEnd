import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_reply_response.freezed.dart';
part 'history_reply_response.g.dart';

@freezed
abstract class HistoryReplyResponse with _$HistoryReplyResponse {
  const factory HistoryReplyResponse({
    required int id,
    required String writerUuid,
    required String profileImage,
    required String nickname,
    required String createDate,
    required String modifiedDate,
    required String content,
  }) = _HistoryReplyResponse;

  factory HistoryReplyResponse.fromJson(Map<String, dynamic> json) => _$HistoryReplyResponseFromJson(json);
}
