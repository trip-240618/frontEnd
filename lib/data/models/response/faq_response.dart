import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_response.freezed.dart';
part 'faq_response.g.dart';

@freezed
abstract class FaqResponse with _$FaqResponse {
  const factory FaqResponse({
    required int id,
    required String title,
    required String type,
  }) = _FaqResponse;

  factory FaqResponse.fromJson(Map<String, dynamic> json) => _$FaqResponseFromJson(json);
}
