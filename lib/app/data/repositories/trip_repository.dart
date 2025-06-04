import 'package:tripStory/app/data/models/trip_room_model.dart';

abstract class TripRepository {
  Future<List<TripRoomModel>> fetchComingTrips();

  Future<List<TripRoomModel>> fetchLastTrips();

  Future<List<TripRoomModel>> fetchBookmarkedTrips();

  Future<bool> updateBookmark(
    int tripId,
  );
}
