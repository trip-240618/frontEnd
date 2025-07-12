import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrap_modify_request.freezed.dart';
part 'scrap_modify_request.g.dart';

@freezed
abstract class ScrapModifyRequest with _$ScrapModifyRequest {
  const factory ScrapModifyRequest({
    required int id,
    required String title,
    required String content,
    required bool hasImage,
    required String color,
    List<String>? photoList,
  }) = _ScrapModifyRequest;

  factory ScrapModifyRequest.fromJson(Map<String, dynamic> json) => _$ScrapModifyRequestFromJson(json);
}

@freezed
abstract class ScrapPhotoList with _$ScrapPhotoList {
  const factory ScrapPhotoList({
    required int id,
    required String imageUrl,
  }) = _ScrapPhotoList;

  factory ScrapPhotoList.fromJson(Map<String, dynamic> json) => _$ScrapPhotoListFromJson(json);
}
