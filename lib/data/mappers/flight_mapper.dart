import 'package:tripStory/data/models/request/flight_request.dart';
import 'package:tripStory/data/models/response/flight_response.dart';
import 'package:tripStory/domain/entities/flight_entity.dart';

class FlightMapper {
  static FlightEntity toEntity(FlightResponse response) {
    return FlightEntity(
      id: response.flightId,
      airlineCode: response.airlineCode,
      airlineNumber: response.airlineNumber,
      departureDateTime: DateTime.parse(response.departureDate),
      departureAirport: response.departureAirport,
      departureAirportKr: response.departureAirport_kr,
      arrivalDateTime: DateTime.parse(response.arrivalDate),
      arrivalAirport: response.arrivalAirport,
      arrivalAirportKr: response.arrivalAirport_kr,
    );
  }

  static FlightRequest toRequest(FlightEntity entity) {
    return FlightRequest(
      flightId: entity.id,
      airlineCode: entity.airlineCode,
      airlineNumber: entity.airlineNumber,
      departureDate: entity.departureDateTime.toString(),
      departureAirport: entity.departureAirport,
      departureAirport_kr: entity.departureAirportKr ?? "",
      arrivalDate: entity.arrivalDateTime.toString(),
      arrivalAirport: entity.arrivalAirport,
      arrivalAirport_kr: entity.arrivalAirportKr ?? "",
    );
  }
}
