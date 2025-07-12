import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice_detail_response.freezed.dart';
part 'notice_detail_response.g.dart';

@freezed
abstract class NoticeDetailResponse with _$NoticeDetailResponse {
  const factory NoticeDetailResponse({
    required int id,
    required String type,
    required String content,
    required String duration,
    required String reason,
    required String createDate,
  }) = _NoticeDetailResponse;

  factory NoticeDetailResponse.fromJson(Map<String, dynamic> json) => _$NoticeDetailResponseFromJson(json);
}
