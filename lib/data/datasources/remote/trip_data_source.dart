import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/request/scrap_create_request.dart';
import 'package:tripStory/data/models/request/plan_j_create_request.dart';
import 'package:tripStory/data/models/request/plan_j_modify_request.dart';
import 'package:tripStory/data/models/request/trip_room_create_request.dart';
import 'package:tripStory/data/models/response/scrap_detail_response.dart';
import 'package:tripStory/data/models/response/scrap_response.dart';
import 'package:tripStory/data/models/response/plan_j_response.dart';
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

  @GET("/{tripId}/scrap/list")
  Future<List<ScrapResponse>> fetchScraps(
    @Path("tripId") int tripId,
  );

  @POST("/{tripId}/scrap/create")
  Future<ScrapDetailResponse> createScrap(
    @Path("tripId") int tripId,
    @Body() ScrapCreateRequest request,
  );

  @GET("/{tripId}/plan/j/list")
  Future<List<PlanJResponse>> fetchJPlan(
    @Path("tripId") int tripId,
    @Query("day") int day,
    @Query("locker") bool locker,
  );

  @POST("/{tripId}/plan/j/create")
  Future<void> postCreateJPlan(
    @Path("tripId") int tripId,
    @Body() PlanJCreateRequest request,
  );

  @DELETE("/{tripId}/plan/j/delete")
  Future<void> deleteJPlan(
    @Path("tripId") int tripId,
    @Query("planId") int planId,
    @Query("day") int day,
  );

  @PUT("/{tripId}/plan/j/edit/modify")
  Future<void> putModifyJPlan(
    @Path("tripId") int tripId,
    @Body() PlanJModifyRequest request,
  );
}
