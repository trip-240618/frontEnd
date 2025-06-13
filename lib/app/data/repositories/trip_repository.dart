import 'package:tripStory/app/data/models/trip_room.dart';
import 'package:tripStory/app/data/models/trip_room_create_request.dart';
import 'package:tripStory/app/data/models/trip_room_create_response.dart';
import 'package:tripStory/core/network_result.dart';

abstract class TripRepository {
  Future<NetworkResult<List<TripRoom>>> fetchComingTrips();

  Future<NetworkResult<List<TripRoom>>> fetchLastTrips();

  Future<NetworkResult<List<TripRoom>>> fetchBookmarkedTrips();

  Future<NetworkResult<bool>> updateBookmark(
    int tripId,
  );

  Future<NetworkResult<TripRoomCreateResponse>> postCreateTrip(
    TripRoomCreateRequest tripRoomCreateRequest,
  );

  Future<NetworkResult<TripRoom>> getEnterTrip({
    required int tripId,
  });
}
