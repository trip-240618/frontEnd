import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/data/models/response/history_response.dart';

part 'histories_response.freezed.dart';
part 'histories_response.g.dart';

@freezed
abstract class HistoriesResponse with _$HistoriesResponse {
  const factory HistoriesResponse({
    required String photoDate,
    required List<HistoryResponse> historyList,
  }) = _HistoriesResponse;

  factory HistoriesResponse.fromJson(Map<String, dynamic> json) => _$HistoriesResponseFromJson(json);
}
