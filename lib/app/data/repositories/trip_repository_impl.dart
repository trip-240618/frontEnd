import 'package:tripStory/app/api/tripApi.dart';
import 'package:tripStory/app/data/models/trip_room_model.dart';

import 'trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final ApiTripClient apiClient;

  TripRepositoryImpl(this.apiClient);

  @override
  Future<List<TripRoomModel>> fetchComingTrips() async {
    final result = await apiClient.inComingTripGet();
    return result.map((e) => TripRoomModel.fromJson(e)).toList();
  }

  @override
  Future<List<TripRoomModel>> fetchLastTrips() async {
    final result = await apiClient.lastTripGet();
    return result.map((e) => TripRoomModel.fromJson(e)).toList();
  }

  @override
  Future<List<TripRoomModel>> fetchBookmarkedTrips() async {
    final result = await apiClient.bookMarkTripGet();
    return result.map((e) => TripRoomModel.fromJson(e)).toList();
  }
}
