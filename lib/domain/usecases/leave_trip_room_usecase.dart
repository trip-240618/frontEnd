import 'package:tripStory/core/enum/trip_type.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class LeaveTripRoomParams {
  final TripType tripType;
  final int tripId;

  const LeaveTripRoomParams({
    required this.tripType,
    required this.tripId,
  });
}

class LeaveTripRoomUsecase implements UseCase<void, LeaveTripRoomParams> {
  final TripRepository _repository;

  LeaveTripRoomUsecase(this._repository);

  @override
  ResultFuture<void> call(LeaveTripRoomParams params) async {
    return await _repository.deleteLeaveTripRoom(
      tripType: params.tripType.name,
      tripId: params.tripId,
    );
  }
}
