import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class DeleteTripRoomUsecase implements UseCase<void, int> {
  final TripRepository _tripRepository;

  DeleteTripRoomUsecase(this._tripRepository);

  @override
  ResultFuture<void> call(int tripId) async {
    return await _tripRepository.deleteTripRoom(
      tripId: tripId,
    );
  }
}
