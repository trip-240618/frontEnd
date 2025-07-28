import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/trip_room_create_request.dart';
import 'package:tripStory/domain/entities/scrap_entity.dart';
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

  ResultFuture<List<ScrapEntity>> fetchScraps({
    required int tripId,
  });
}
