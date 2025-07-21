import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_auto_response.freezed.dart';
part 'location_auto_response.g.dart';

@freezed
abstract class LocationAutoResponse with _$LocationAutoResponse {
  const factory LocationAutoResponse({
    required String placeId,
    required String address,
    required String secondaryAddress,
  }) = _LocationAutoResponse;

  factory LocationAutoResponse.fromJson(Map<String, dynamic> json) => _$LocationAutoResponseFromJson(json);
}
