import 'package:tripStory/app/data/models/trip_room.dart';

abstract class TripRepository {
  Future<List<TripRoom>> fetchComingTrips();

  Future<List<TripRoom>> fetchLastTrips();

  Future<List<TripRoom>> fetchBookmarkedTrips();

  Future<bool> updateBookmark(
    int tripId,
  );
}
