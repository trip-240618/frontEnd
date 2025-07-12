import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_request.freezed.dart';
part 'faq_request.g.dart';

@freezed
abstract class FaqRequest with _$FaqRequest {
  const factory FaqRequest({
    required String title,
    required String type,
    required String content,
  }) = _FaqRequest;

  factory FaqRequest.fromJson(Map<String, dynamic> json) => _$FaqRequestFromJson(json);
}
