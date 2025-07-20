import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/request/trip_room_create_request.dart';
import 'package:tripStory/data/models/response/trip_room_create_response.dart';
import 'package:tripStory/data/models/response/trip_room_response.dart';

part 'trip_data_source.g.dart';

@RestApi(baseUrl: "/trip")
abstract class TripDataSource {
  factory TripDataSource(Dio dio, {String baseUrl}) = _TripDataSource;

  @GET("/list/incoming")
  Future<List<TripRoomResponse>> inComingTripGet();

  @GET("/list/last")
  Future<List<TripRoomResponse>> lastTripGet();

  @GET("/list/bookmark")
  Future<List<TripRoomResponse>> bookMarkTripGet();

  @PUT("/bookmark/toggle")
  Future<bool> updateBookMark(
    @Query("tripId") int tripId,
  );

  @POST("/create")
  Future<TripRoomCreateResponse> postCreateTrip(
    @Body() TripRoomCreateRequest request,
  );

  @GET("/enter")
  Future<TripRoomResponse> getEnterTrip(
    @Query("tripId") int tripId,
  );

  @GET("/join")
  Future<TripRoomResponse> fetchJoinTrip(
    @Query("invitationCode") String invitationCode,
  );
}
