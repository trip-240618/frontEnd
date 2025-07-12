import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/data/models/response/tag_response.dart';

part 'history_modify_request.freezed.dart';
part 'history_modify_request.g.dart';

@freezed
abstract class HistoryModifyRequest with _$HistoryModifyRequest {
  const factory HistoryModifyRequest({
    required String memo,
    required String thumbnail,
    required String imageUrl,
    required List<TagResponse> tags,
  }) = _HistoryModifyRequest;

  factory HistoryModifyRequest.fromJson(Map<String, dynamic> json) => _$HistoryModifyRequestFromJson(json);
}
