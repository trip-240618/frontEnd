import 'package:tripStory/app/data/models/trip_room.dart';
import 'package:tripStory/app/data/models/trip_room_create_request.dart';
import 'package:tripStory/app/data/models/trip_room_create_response.dart';

abstract class TripRepository {
  Future<List<TripRoom>> fetchComingTrips();

  Future<List<TripRoom>> fetchLastTrips();

  Future<List<TripRoom>> fetchBookmarkedTrips();

  Future<bool> updateBookmark(
    int tripId,
  );

  Future<TripRoomCreateResponse> postCreateTrip(
    TripRoomCreateRequest tripRoomCreateRequest,
  );

  Future<void> getEnterTrip({
    required int tripId,
  });
}
