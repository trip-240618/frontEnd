import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/trip_room_create_request.dart';
import 'package:tripStory/domain/entities/trip_room_create_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class CreateTripRoomUseCase {
  final TripRepository _tripRepository;

  CreateTripRoomUseCase(this._tripRepository);

  ResultFuture<TripRoomCreateEntity> call(TripRoomCreateRequest request) {
    return _tripRepository.postCreateTrip(request);
  }
}
