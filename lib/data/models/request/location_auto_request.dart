import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_auto_request.freezed.dart';
part 'location_auto_request.g.dart';

@freezed
abstract class LocationAutoRequest with _$LocationAutoRequest {
  const factory LocationAutoRequest({
    required String input,
    required String languageCode,
    required List<String> includedRegionCodes,
  }) = _LocationAutoRequest;

  factory LocationAutoRequest.fromJson(Map<String, dynamic> json) => _$LocationAutoRequestFromJson(json);
}
