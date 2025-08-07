import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/response/flight_response.dart';

part 'flight_data_source.g.dart';

@RestApi(baseUrl: "/flight")
abstract class FlightDataSource {
  factory FlightDataSource(Dio dio, {String baseUrl}) = _FlightDataSource;

  @GET("/search")
  Future<FlightResponse> fetchFlight({
    @Query("flightNumber") required int flightNumber,
    @Query("carrierCode") required String carrierCode,
    @Query("departureDate") required String departureDate,
  });
}
