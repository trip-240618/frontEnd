import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/data/models/response/tag_response.dart';

part 'history_create_request.freezed.dart';
part 'history_create_request.g.dart';

@freezed
abstract class HistoryCreateRequest with _$HistoryCreateRequest {
  const factory HistoryCreateRequest({
    required List<HistoryCreateItem> historyCreateRequestDtos,
  }) = _HistoryCreateRequest;

  factory HistoryCreateRequest.fromJson(Map<String, dynamic> json) => _$HistoryCreateRequestFromJson(json);
}

@freezed
abstract class HistoryCreateItem with _$HistoryCreateItem {
  const factory HistoryCreateItem({
    required String thumbnail,
    required String imageUrl,
    double? latitude,
    double? longitude,
    String? photoDate,
    List<TagResponse>? tags,
  }) = _HistoryCreateItem;

  factory HistoryCreateItem.fromJson(Map<String, dynamic> json) => _$HistoryCreateItemFromJson(json);
}
