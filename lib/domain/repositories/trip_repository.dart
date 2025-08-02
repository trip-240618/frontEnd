import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/plan_j_create_request.dart';
import 'package:tripStory/data/models/request/plan_j_modify_request.dart';
import 'package:tripStory/data/models/request/plan_j_swap_request.dart';
import 'package:tripStory/data/models/request/trip_room_create_request.dart';
import 'package:tripStory/domain/entities/j_plan_entity.dart';
import 'package:tripStory/domain/entities/trip_room_create_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';

abstract class TripRepository {
  ResultFuture<List<TripRoomEntity>> fetchComingTrips();

  ResultFuture<List<TripRoomEntity>> fetchLastTrips();

  ResultFuture<List<TripRoomEntity>> fetchBookmarkedTrips();

  ResultFuture<bool> updateBookmark(int tripId);

  ResultFuture<TripRoomCreateEntity> postCreateTrip(
    TripRoomCreateRequest request,
  );

  ResultFuture<TripRoomEntity> getEnterTrip({
    required int tripId,
  });

  ResultFuture<TripRoomEntity> fetchJoinTrip({
    required String invitationCode,
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
    required PlanJModifyRequest request,
  });

  ResultFuture<void> putSwapJPlan({
    required int tripId,
    required PlanJSwapRequest request,
  });

  ResultFuture<void> fetchRegisterJPlan({
    required int tripId,
    required int day,
  });
}
