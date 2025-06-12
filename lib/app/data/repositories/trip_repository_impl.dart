import 'package:tripStory/app/data/models/trip_room.dart';
import 'package:tripStory/app/data/models/trip_room_create_request.dart';
import 'package:tripStory/app/data/models/trip_room_create_response.dart';
import 'package:tripStory/app/data/providers/trip_client.dart';

import 'trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripClient _tripClient;

  TripRepositoryImpl(this._tripClient);

  @override
  Future<List<TripRoom>> fetchComingTrips() async => await _tripClient.inComingTripGet();

  @override
  Future<List<TripRoom>> fetchLastTrips() async => await _tripClient.lastTripGet();

  @override
  Future<List<TripRoom>> fetchBookmarkedTrips() async => await _tripClient.bookMarkTripGet();

  @override
  Future<bool> updateBookmark(int tripId) async {
    return await _tripClient.updateBookMark(tripId);
  }

  @override
  Future<TripRoomCreateResponse> postCreateTrip(
    TripRoomCreateRequest tripRoomCreateRequest,
  ) async {
    return await _tripClient.postCreateTrip(tripRoomCreateRequest);
  }

  @override
  Future<TripRoom> getEnterTrip({
    required int tripId,
  }) async {
    return await _tripClient.getEnterTrip(tripId);
  }
}
