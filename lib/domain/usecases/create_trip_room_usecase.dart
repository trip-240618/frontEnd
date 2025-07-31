import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/trip_room_create_request.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/trip_room_create_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class CreateTripRoomUseCase implements UseCase<TripRoomCreateEntity, TripRoomCreateRequest> {
  final TripRepository _tripRepository;

  CreateTripRoomUseCase(this._tripRepository);

  @override
  ResultFuture<TripRoomCreateEntity> call(TripRoomCreateRequest request) async {
    return await _tripRepository.postCreateTrip(request);
  }
}
