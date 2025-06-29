import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class FetchEnterRoomUsecase implements UseCase<TripRoomEntity, int> {
  final TripRepository repository;

  FetchEnterRoomUsecase(this.repository);

  @override
  ResultFuture<TripRoomEntity> call(int tripId) async {
    return await repository.getEnterTrip(tripId: tripId);
  }
}
