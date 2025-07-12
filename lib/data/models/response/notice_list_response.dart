import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice_list_response.freezed.dart';
part 'notice_list_response.g.dart';

@freezed
abstract class NoticeListResponse with _$NoticeListResponse {
  const factory NoticeListResponse({
    required int id,
    required String type,
    required String title,
    required String createDate,
  }) = _NoticeListResponse;

  factory NoticeListResponse.fromJson(Map<String, dynamic> json) => _$NoticeListResponseFromJson(json);
}
