import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_request.freezed.dart';
part 'file_request.g.dart';

@freezed
abstract class FileRequest with _$FileRequest {
  const factory FileRequest({
    required String prefix,
    required int photoCnt,
  }) = _FileRequest;

  factory FileRequest.fromJson(Map<String, dynamic> json) => _$FileRequestFromJson(json);
}
