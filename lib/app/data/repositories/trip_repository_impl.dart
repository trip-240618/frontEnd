import 'package:tripStory/app/data/models/trip_room_model.dart';
import 'package:tripStory/app/data/providers/trip_client.dart';

import 'trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripClient _tripClient;

  TripRepositoryImpl(this._tripClient);

  @override
  Future<List<TripRoomModel>> fetchComingTrips() async {
    final result = await _tripClient.inComingTripGet();
    return result.map((e) => TripRoomModel.fromJson(e)).toList();
  }

  @override
  Future<List<TripRoomModel>> fetchLastTrips() async {
    final result = await _tripClient.lastTripGet();
    return result.map((e) => TripRoomModel.fromJson(e)).toList();
  }

  @override
  Future<List<TripRoomModel>> fetchBookmarkedTrips() async {
    final result = await _tripClient.bookMarkTripGet();
    return result.map((e) => TripRoomModel.fromJson(e)).toList();
  }

  @override
  Future<bool> updateBookmark(int tripId) async {
    return await _tripClient.updateBookMark(tripId);
  }
}
