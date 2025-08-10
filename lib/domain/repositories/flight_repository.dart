import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/flight_request.dart';
import 'package:tripStory/domain/entities/flight_entity.dart';

abstract class FlightRepository {
  ResultFuture<FlightEntity> fetchSearchFlight(
    int flightNumber,
    String carrierCode,
    String departureDate,
  );

  ResultFuture<FlightEntity> postCreateFlight(
    int tripId,
    FlightRequest request,
  );

  ResultFuture<List<FlightEntity>> fetchFlight(
    int tripId,
  );

  ResultFuture<void> deleteFlight(
    int tripId,
    int flightId,
  );
}
