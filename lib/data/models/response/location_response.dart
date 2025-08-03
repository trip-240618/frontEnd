import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_response.freezed.dart';
part 'location_response.g.dart';

@freezed
abstract class LocationResponse with _$LocationResponse {
  const factory LocationResponse({
    required String formattedAddress,
    required LocationCoordinates location,
    required DisplayName displayName,
  }) = _LocationResponse;

  factory LocationResponse.fromJson(Map<String, dynamic> json) => _$LocationResponseFromJson(json);
}

@freezed
abstract class LocationCoordinates with _$LocationCoordinates {
  const factory LocationCoordinates({
    required double latitude,
    required double longitude,
  }) = _LocationCoordinates;

  factory LocationCoordinates.fromJson(Map<String, dynamic> json) => _$LocationCoordinatesFromJson(json);
}

@freezed
abstract class DisplayName with _$DisplayName {
  const factory DisplayName({
    required String text,
    required String languageCode,
  }) = _DisplayName;

  factory DisplayName.fromJson(Map<String, dynamic> json) => _$DisplayNameFromJson(json);
}
