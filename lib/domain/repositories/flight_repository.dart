import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/entities/flight_entity.dart';

abstract class FlightRepository {
  ResultFuture<FlightEntity> fetchFlight(
    int flightNumber,
    String carrierCode,
    String departureDate,
  );
}
