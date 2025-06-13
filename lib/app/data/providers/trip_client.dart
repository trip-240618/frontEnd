import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/app/data/models/trip_room.dart';
import 'package:tripStory/app/data/models/trip_room_create_request.dart';
import 'package:tripStory/app/data/models/trip_room_create_response.dart';

part 'trip_client.g.dart';

@RestApi(baseUrl: "https://trip-story.site/trip")
abstract class TripClient {
  factory TripClient(Dio dio, {String baseUrl}) = _TripClient;

  @GET("/list/incoming")
  Future<List<TripRoom>> inComingTripGet();

  @GET("/list/last")
  Future<List<TripRoom>> lastTripGet();

  @GET("/list/bookmark")
  Future<List<TripRoom>> bookMarkTripGet();

  @PUT("/bookmark/toggle")
  Future<bool> updateBookMark(@Query("tripId") int tripId);

  @POST("/create")
  Future<TripRoomCreateResponse> postCreateTrip(
    @Body() TripRoomCreateRequest request,
  );

  @GET("/enter")
  Future<TripRoom> getEnterTrip(
    @Query("tripId") int tripId,
  );
}
