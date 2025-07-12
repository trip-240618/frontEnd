import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_response.freezed.dart';
part 'file_response.g.dart';

@freezed
abstract class FileResponse with _$FileResponse {
  const factory FileResponse({
    required List<String> preSignedUrls,
  }) = _FileResponse;

  factory FileResponse.fromJson(Map<String, dynamic> json) => _$FileResponseFromJson(json);
}
