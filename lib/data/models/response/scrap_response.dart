import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrap_response.freezed.dart';
part 'scrap_response.g.dart';

@freezed
abstract class ScrapResponse with _$ScrapResponse {
  const factory ScrapResponse({
    required int id,
    required String writerUuid,
    required String nickname,
    required String title,
    required String preview,
    required bool hasImage,
    required String color,
    required bool bookmark,
    required String createDate,
  }) = _ScrapResponse;

  factory ScrapResponse.fromJson(Map<String, dynamic> json) => _$ScrapResponseFromJson(json);
}
