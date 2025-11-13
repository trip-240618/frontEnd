import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/request/history_create_request.dart';
import 'package:tripStory/data/models/request/history_reply_modify_request.dart';
import 'package:tripStory/data/models/request/history_reply_request.dart';
import 'package:tripStory/data/models/request/plan_j_create_request.dart';
import 'package:tripStory/data/models/request/plan_j_modify_request.dart';
import 'package:tripStory/data/models/request/plan_j_swap_request.dart';
import 'package:tripStory/data/models/request/scrap_create_request.dart';
import 'package:tripStory/data/models/request/scrap_modify_request.dart';
import 'package:tripStory/data/models/request/trip_room_create_request.dart';
import 'package:tripStory/data/models/request/trip_room_modify_request.dart';
import 'package:tripStory/data/models/response/histories_response.dart';
import 'package:tripStory/data/models/response/history_reply_response.dart';
import 'package:tripStory/data/models/response/history_response.dart';
import 'package:tripStory/data/models/response/plan_j_response.dart';
import 'package:tripStory/data/models/response/scrap_detail_response.dart';
import 'package:tripStory/data/models/response/scrap_response.dart';
import 'package:tripStory/data/models/response/tag_response.dart';
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

  @POST("/join")
  Future<TripRoomResponse> fetchJoinTrip(
    @Query("invitationCode") String invitationCode,
  );

  @PUT("/modify")
  Future<TripRoomResponse> putModifyTrip(
    @Query("tripId") int tripId,
    @Body() TripRoomModifyRequest request,
  );

  @DELETE("/delete")
  Future<void> deleteTripRoom(
    @Query("tripId") int tripId,
  );

  @DELETE("/leave")
  Future<void> deleteLeaveTripRoom(
    @Query("tripType") String tripType,
    @Query("tripId") int tripId,
  );

  @DELETE("/kick")
  Future<void> deleteKickMember(
    @Query("tripId") int tripId,
    @Query("tripType") String tripType,
    @Query("uuid") String uuid,
  );

  @GET("/{tripId}/scrap/list")
  Future<List<ScrapResponse>> fetchScraps(
    @Path("tripId") int tripId,
  );

  @GET("/{tripId}/scrap/bookmark/list")
  Future<List<ScrapResponse>> fetchBookmarkedScraps(
    @Path("tripId") int tripId,
  );

  @POST("/{tripId}/scrap/bookmark/toggle")
  Future<bool> toggleScrapBookmark(
    @Path("tripId") int tripId,
    @Query("scrapId") int scrapId,
  );

  @POST("/{tripId}/scrap/create")
  Future<ScrapDetailResponse> createScrap(
    @Path("tripId") int tripId,
    @Body() ScrapCreateRequest request,
  );

  @PUT("/{tripId}/scrap/modify")
  Future<ScrapDetailResponse> updateScrap(
    @Path("tripId") int tripId,
    @Body() ScrapModifyRequest request,
  );

  @DELETE("/{tripId}/scrap/delete")
  Future<void> deleteScrap(
    @Path("tripId") int tripId,
    @Query("scrapId") int scrapId,
  );

  @GET("/{tripId}/scrap/detail/{scrapId}")
  Future<ScrapDetailResponse> fetchScrapDetail(
    @Path("tripId") int tripId,
    @Path("scrapId") int scrapId,
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

  @PUT("/{tripId}/plan/j/edit/swap")
  Future<void> putSwapJPlan(
    @Path("tripId") int tripId,
    @Body() PlanJSwapRequest request,
  );

  @GET("/{tripId}/plan/j/{day}/edit/register")
  Future<void> fetchRegisterJPlan(
    @Path("tripId") int tripId,
    @Path("day") int day,
  );

  @GET("/{tripId}/plan/j/{day}/edit/finish")
  Future<void> fetchRegisterFinishJPlan(
    @Path("tripId") int tripId,
    @Path("day") int day,
  );

  @GET("/{tripId}/history/list")
  Future<List<HistoriesResponse>> fetchHistoryList(
    @Path("tripId") int tripId,
  );

  @GET("/{tripId}/history/{historyId}")
  Future<HistoryResponse> fetchHistoryDetail(
    @Path("tripId") int tripId,
    @Path("historyId") int historyId,
  );

  @POST("/{tripId}/history/create/many")
  Future<List<HistoriesResponse>> postCreateManyHistory(
    @Path("tripId") int tripId,
    @Body() HistoryCreateRequest request,
  );

  @GET("/{tripId}/history/{historyId}/reply/list")
  Future<List<HistoryReplyResponse>> fetchReplies(
    @Path("tripId") int tripId,
    @Path("historyId") int historyId,
  );

  @POST("/{tripId}/history/{historyId}/reply/create")
  Future<List<HistoryReplyResponse>> postReplyCreate(
    @Path("tripId") int tripId,
    @Path("historyId") int historyId,
    @Body() HistoryReplyRequest request,
  );

  @PUT("/{tripId}/history/{historyId}/like")
  Future<bool> putHistoryToggle(
    @Path("tripId") int tripId,
    @Path("historyId") int historyId,
  );

  @DELETE("/{tripId}/history/delete/{historyId}")
  Future<void> deleteHistory(
    @Path("tripId") int tripId,
    @Path("historyId") int historyId,
  );

  @POST("/history/{historyId}/report")
  Future<void> reportHistory(
    @Path("tripId") int tripId,
    @Query("reason") String reason,
  );

  @PUT("/{tripId}/history/{historyId}/reply/modify")
  Future<List<HistoryReplyResponse>> putReportModify(
    @Path("tripId") int tripId,
    @Path("historyId") int historyId,
    @Body() HistoryReplyModifyRequest request,
  );

  @DELETE("/{tripId}/history/{historyId}/reply/delete")
  Future<List<HistoryReplyResponse>> deleteReply(
    @Path("tripId") int tripId,
    @Path("historyId") int historyId,
    @Query("replyId") int replyId,
  );

  @GET("/{tripId}/history/tags")
  Future<List<TagResponse>> fetchTags(
    @Path("tripId") int tripId,
  );

  @GET("/{tripId}/history/search")
  Future<List<HistoryResponse>> fetchSearchHistory(
    @Path("tripId") int tripId,
    @Query("uuid") String? uuid,
    @Query("tagName") String? tagName,
    @Query("tagColor") String? tagColor,
  );
}
