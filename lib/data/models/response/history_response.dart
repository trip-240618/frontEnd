import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/data/models/response/tag_response.dart';

part 'history_response.freezed.dart';
part 'history_response.g.dart';

@freezed
abstract class HistoryResponse with _$HistoryResponse {
  const factory HistoryResponse({
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
    String? photoDate,
    List<TagResponse>? tags,
  }) = _HistoryResponse;

  factory HistoryResponse.fromJson(Map<String, dynamic> json) => _$HistoryResponseFromJson(json);
}
