import 'package:freezed_annotation/freezed_annotation.dart';

part 'version_response.freezed.dart';
part 'version_response.g.dart';

@freezed
abstract class VersionResponse with _$VersionResponse {
  const factory VersionResponse({
    required int id,
    required String androidVersion,
    required String iosVersion,
    required bool forceUpdate,
    required String createDate,
  }) = _VersionResponse;

  factory VersionResponse.fromJson(Map<String, dynamic> json) => _$VersionResponseFromJson(json);
}
