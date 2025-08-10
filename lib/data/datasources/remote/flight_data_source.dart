import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/request/flight_request.dart';
import 'package:tripStory/data/models/response/flight_response.dart';

part 'flight_data_source.g.dart';

@RestApi(baseUrl: "/flight")
abstract class FlightDataSource {
  factory FlightDataSource(Dio dio, {String baseUrl}) = _FlightDataSource;

  @GET("/search")
  Future<FlightResponse> fetchSearchFlight({
    @Query("flightNumber") required int flightNumber,
    @Query("carrierCode") required String carrierCode,
    @Query("departureDate") required String departureDate,
  });

  @POST("/trip/{tripId}/create")
  Future<FlightResponse> postCreateFlight({
    @Path("tripId") required int tripId,
    @Body() required FlightRequest request,
  });

  @GET("/trip/{tripId}/list")
  Future<List<FlightResponse>> fetchFlight({
    @Path("tripId") required int tripId,
  });

  @DELETE("/trip/{tripId}/delete")
  Future<void> deleteFlight({
    @Path("tripId") required int tripId,
    @Query("flightId") required int flightId,
  });
}
