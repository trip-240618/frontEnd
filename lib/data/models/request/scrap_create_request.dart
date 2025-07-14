import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrap_create_request.freezed.dart';
part 'scrap_create_request.g.dart';

@freezed
abstract class ScrapCreateRequest with _$ScrapCreateRequest {
  const factory ScrapCreateRequest({
    required String title,
    required String content,
    required bool hasImage,
    required String color,
    List<String>? photoList,
  }) = _ScrapCreateRequest;

  factory ScrapCreateRequest.fromJson(Map<String, dynamic> json) => _$ScrapCreateRequestFromJson(json);
}
