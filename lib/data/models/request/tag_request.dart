import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_request.freezed.dart';
part 'tag_request.g.dart';

@freezed
abstract class TagRequest with _$TagRequest {
  const factory TagRequest({
    required int id,
    required String tagColor,
    required String tagName,
  }) = _TagRequest;

  factory TagRequest.fromJson(Map<String, dynamic> json) => _$TagRequestFromJson(json);
}
