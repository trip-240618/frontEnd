import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_reply_request.freezed.dart';
part 'history_reply_request.g.dart';

@freezed
abstract class HistoryReplyRequest with _$HistoryReplyRequest {
  const factory HistoryReplyRequest({
    required String content,
  }) = _HistoryReplyRequest;

  factory HistoryReplyRequest.fromJson(Map<String, dynamic> json) => _$HistoryReplyRequestFromJson(json);
}
