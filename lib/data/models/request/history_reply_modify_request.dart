import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_reply_modify_request.freezed.dart';
part 'history_reply_modify_request.g.dart';

@freezed
abstract class HistoryReplyModifyRequest with _$HistoryReplyModifyRequest {
  const factory HistoryReplyModifyRequest({
    required int replyId,
    required String content,
  }) = _HistoryReplyModifyRequest;

  factory HistoryReplyModifyRequest.fromJson(Map<String, dynamic> json) => _$HistoryReplyModifyRequestFromJson(json);
}
