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
}
