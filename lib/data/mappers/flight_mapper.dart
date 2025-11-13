import 'package:tripStory/data/models/request/flight_request.dart';
import 'package:tripStory/data/models/response/flight_response.dart';
import 'package:tripStory/domain/entities/flight_entity.dart';

class FlightMapper {
  static FlightEntity toEntity(FlightResponse response) {
    return FlightEntity(
      flightId: response.flightId,
      airlineCode: response.airlineCode,
      airlineNumber: response.airlineNumber,
      departureDateTime: DateTime.parse(response.departureDate).toLocal(),
      departureAirport: response.departureAirport,
      departureAirportKr: response.departureAirport_kr,
      arrivalDateTime: DateTime.parse(response.arrivalDate).toLocal(),
      arrivalAirport: response.arrivalAirport,
      arrivalAirportKr: response.arrivalAirport_kr,
    );
  }

  static FlightRequest toRequest(FlightEntity entity) {
    return FlightRequest(
      flightId: entity.flightId,
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
