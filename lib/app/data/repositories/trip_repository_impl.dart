import 'package:tripStory/app/data/models/trip_room.dart';
import 'package:tripStory/app/data/models/trip_room_create_request.dart';
import 'package:tripStory/app/data/models/trip_room_create_response.dart';
import 'package:tripStory/app/data/providers/trip_client.dart';
import 'package:tripStory/core/network_executor.dart';
import 'package:tripStory/core/network_result.dart';

import 'trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripClient _tripClient;

  TripRepositoryImpl(this._tripClient);

  @override
  Future<NetworkResult<List<TripRoom>>> fetchComingTrips() {
    return NetworkExecutor.run(() => _tripClient.inComingTripGet());
  }

  @override
  Future<NetworkResult<List<TripRoom>>> fetchLastTrips() {
    return NetworkExecutor.run(() => _tripClient.lastTripGet());
  }

  @override
  Future<NetworkResult<List<TripRoom>>> fetchBookmarkedTrips() {
    return NetworkExecutor.run(() => _tripClient.bookMarkTripGet());
  }

  @override
  Future<NetworkResult<bool>> updateBookmark(int tripId) {
    return NetworkExecutor.run(() => _tripClient.updateBookMark(tripId));
  }

  @override
  Future<NetworkResult<TripRoomCreateResponse>> postCreateTrip(
    TripRoomCreateRequest request,
  ) {
    return NetworkExecutor.run(() => _tripClient.postCreateTrip(request));
  }

  @override
  Future<NetworkResult<TripRoom>> getEnterTrip({
    required int tripId,
  }) {
    return NetworkExecutor.run(() => _tripClient.getEnterTrip(tripId));
  }
}
