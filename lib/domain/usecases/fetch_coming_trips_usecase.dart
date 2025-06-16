import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

import '../base/usecase.dart';

class FetchComingTripsUseCase implements UseCase<List<TripRoomEntity>, NoParams> {
  final TripRepository repository;

  FetchComingTripsUseCase(this.repository);

  @override
  ResultFuture<List<TripRoomEntity>> call(NoParams params) async {
    return await repository.fetchComingTrips();
  }
}
