import 'package:freezed_annotation/freezed_annotation.dart';

part 'flight_response.freezed.dart';
part 'flight_response.g.dart';

@freezed
abstract class FlightResponse with _$FlightResponse {
  const factory FlightResponse({
    required int flightId,
    required String airlineCode,
    required int airlineNumber,
    required String departureDate,
    required String departureAirport,
    required String departureAirport_kr,
    required String arrivalDate,
    required String arrivalAirport,
    required String arrivalAirport_kr,
  }) = _FlightResponse;

  factory FlightResponse.fromJson(Map<String, dynamic> json) => _$FlightResponseFromJson(json);
}
