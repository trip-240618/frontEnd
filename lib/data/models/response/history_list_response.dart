import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/data/models/response/history_response.dart';

part 'history_list_response.freezed.dart';
part 'history_list_response.g.dart';

@freezed
abstract class HistoryListResponse with _$HistoryListResponse {
  const factory HistoryListResponse({
    required String photoDate,
    required List<HistoryResponse> historyList,
  }) = _HistoryListResponse;

  factory HistoryListResponse.fromJson(Map<String, dynamic> json) => _$HistoryListResponseFromJson(json);
}
