import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_response.freezed.dart';
part 'tag_response.g.dart';

@freezed
abstract class TagResponse with _$TagResponse {
  const factory TagResponse({
    int? id,
    required String tagColor,
    required String tagName,
  }) = _TagResponse;

  factory TagResponse.fromJson(Map<String, dynamic> json) => _$TagResponseFromJson(json);
}
