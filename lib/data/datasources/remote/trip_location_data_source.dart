import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/request/location_auto_request.dart';
import 'package:tripStory/data/models/response/location_auto_response.dart';
import 'package:tripStory/data/models/response/location_response.dart';

part 'trip_location_data_source.g.dart';

@RestApi(baseUrl: "/trip/location")
abstract class TripLocationDataSource {
  factory TripLocationDataSource(Dio dio, {String baseUrl}) = _TripLocationDataSource;

  @GET("/place/{placeId}")
  Future<LocationResponse> fetchPlaceDetail(
    @Path("placeId") String placeId,
  );

  @POST("/autocomplete")
  Future<List<LocationAutoResponse>> postAutoComplete(
    @Body() LocationAutoRequest request,
  );
}
