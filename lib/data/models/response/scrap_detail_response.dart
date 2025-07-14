import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrap_detail_response.freezed.dart';
part 'scrap_detail_response.g.dart';

@freezed
abstract class ScrapDetailResponse with _$ScrapDetailResponse {
  const factory ScrapDetailResponse({
    required int id,
    required String writerUuid,
    required String nickname,
    required String title,
    required String preview,
    required bool hasImage,
    required String color,
    required bool bookmark,
    required String createDate,
    required List<ScrapImages> imageDtos,
  }) = _ScrapDetailResponse;

  factory ScrapDetailResponse.fromJson(Map<String, dynamic> json) => _$ScrapDetailResponseFromJson(json);
}

@freezed
abstract class ScrapImages with _$ScrapImages {
  const factory ScrapImages({
    required int id,
    required String imageUrl,
  }) = _ScrapImages;

  factory ScrapImages.fromJson(Map<String, dynamic> json) => _$ScrapImagesFromJson(json);
}
