import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_detail_response.freezed.dart';
part 'faq_detail_response.g.dart';

@freezed
abstract class FaqDetailResponse with _$FaqDetailResponse {
  const factory FaqDetailResponse({
    required String createDate,
    required String modifyDate,
    required int id,
    required String type,
    required String title,
    required String content,
  }) = _FaqDetailResponse;

  factory FaqDetailResponse.fromJson(Map<String, dynamic> json) => _$FaqDetailResponseFromJson(json);
}
