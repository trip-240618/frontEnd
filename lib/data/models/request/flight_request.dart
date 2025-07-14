import 'package:freezed_annotation/freezed_annotation.dart';

part 'flight_request.freezed.dart';
part 'flight_request.g.dart';

@freezed
abstract class FlightRequest with _$FlightRequest {
  const factory FlightRequest({
    required int flightId,
    required String airlineCode,
    required int airlineNumber,
    required String departureDate,
    required String departureAirport,
    required String departureAirport_kr,
    required String arrivalDate,
    required String arrivalAirport,
    required String arrivalAirport_kr,
  }) = _FlightRequest;

  factory FlightRequest.fromJson(Map<String, dynamic> json) => _$FlightRequestFromJson(json);
}
