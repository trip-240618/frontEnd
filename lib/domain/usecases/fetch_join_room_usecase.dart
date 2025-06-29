import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class FetchJoinRoomUsecase implements UseCase<TripRoomEntity, String> {
  final TripRepository repository;

  FetchJoinRoomUsecase(this.repository);

  @override
  ResultFuture<TripRoomEntity> call(String invitationCode) async {
    return await repository.fetchJoinTrip(invitationCode: invitationCode);
  }
}
