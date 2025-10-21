import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/plan_j_create_request.dart';
import 'package:tripStory/data/models/request/plan_j_swap_request.dart';
import 'package:tripStory/domain/entities/histories_create_entity.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/domain/entities/j_plan_entity.dart';
import 'package:tripStory/domain/entities/scrap_create_entity.dart';
import 'package:tripStory/domain/entities/scrap_detail_entity.dart';
import 'package:tripStory/domain/entities/scrap_entity.dart';
import 'package:tripStory/domain/entities/scrap_update_entity.dart';
import 'package:tripStory/domain/entities/trip_room_create_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';

abstract class TripRepository {
  ResultFuture<List<TripRoomEntity>> fetchComingTrips();

  ResultFuture<List<TripRoomEntity>> fetchLastTrips();

  ResultFuture<List<TripRoomEntity>> fetchBookmarkedTrips();

  ResultFuture<bool> updateBookmark(int tripId);

  ResultFuture<TripRoomCreateEntity> postCreateTrip({
    required String name,
    required String tripType,
    required String startDate,
    required String endDate,
    required String color,
    required String country,
    String? thumbnail,
  });

  ResultFuture<TripRoomEntity> getEnterTrip({
    required int tripId,
  });

  ResultFuture<void> deleteTripRoom({
    required int tripId,
  });

  ResultFuture<void> deleteLeaveTripRoom({
    required String tripType,
    required int tripId,
  });

  @override
  ResultFuture<void> deleteKickMember({
    required int tripId,
    required String tripType,
    required String uuid,
  });

  ResultFuture<TripRoomEntity> putModifyTripRoom({
    required int tripId,
    required TripRoomEntity tripRoomEntity,
  });

  ResultFuture<TripRoomEntity> fetchJoinTrip({
    required String invitationCode,
  });

  ResultFuture<List<ScrapEntity>> fetchScraps({
    required int tripId,
  });

  ResultFuture<List<ScrapEntity>> fetchBookmarkedScraps({
    required int tripId,
  });

  ResultFuture<bool> toggleScrapBookmark({
    required int tripId,
    required int scrapId,
  });

  ResultFuture<ScrapDetailEntity> createScrap({
    required int tripId,
    required ScrapCreateEntity scrapCreateEntity,
  });

  ResultFuture<ScrapDetailEntity> updateScrap({
    required int tripId,
    required ScrapUpdateEntity scrapUpdateEntity,
  });

  ResultFuture<void> deleteScrap({
    required int tripId,
    required int scrapId,
  });

  ResultFuture<ScrapDetailEntity> fetchScrapDetail({
    required int tripId,
    required int scrapId,
  });

  ResultFuture<List<JPlanEntity>> fetchJPlan({
    required int tripId,
    required int day,
    required bool locker,
  });

  ResultFuture<void> postCreateJPlan({
    required int tripId,
    required PlanJCreateRequest planJCreateRequest,
  });

  ResultFuture<void> deleteJPlan({
    required int tripId,
    required int planId,
    required int day,
  });

  ResultFuture<void> putModifyJPlan({
    required int tripId,
    required int planId,
    required int dayAfterStart,
    int? orderByDate,
    required String startTime,
    required String title,
    String? place,
    String? memo,
    double? latitude,
    double? longitude,
    required bool locker,
  });

  ResultFuture<void> putSwapJPlan({
    required int tripId,
    required PlanJSwapRequest request,
  });

  ResultFuture<void> fetchRegisterJPlan({
    required int tripId,
    required int day,
  });

  ResultFuture<void> fetchRegisterFinishJPlan({
    required int tripId,
    required int day,
  });

  ResultFuture<List<HistoriesEntity>> fetchHistories({
    required int tripId,
  });

  ResultFuture<HistoryEntity> fetchHistoryDetail({
    required int tripId,
    required int historyId,
  });

  ResultFuture<List<HistoriesEntity>> postCreateManyHistory({
    required HistoriesCreateEntity historiesCreateEntity,
  });
}
