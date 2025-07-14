import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_visited_response.freezed.dart';
part 'country_visited_response.g.dart';

@freezed
abstract class CountryVisitedResponse with _$CountryVisitedResponse {
  const factory CountryVisitedResponse({
    required String country,
    required int visitCnt,
  }) = _CountryVisitedResponse;

  factory CountryVisitedResponse.fromJson(Map<String, dynamic> json) => _$CountryVisitedResponseFromJson(json);
}
