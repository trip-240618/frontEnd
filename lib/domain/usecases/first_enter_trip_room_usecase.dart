import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class FirstEnterTripRoomUsecase implements UseCase<TripRoomEntity, String> {
  final TripRepository _repository;

  FirstEnterTripRoomUsecase(this._repository);

  @override
  ResultFuture<TripRoomEntity> call(String inviteCode) async {
    final joinResult = await _repository.fetchJoinTrip(invitationCode: inviteCode);

    return await joinResult.fold(
      (failure) => Left(failure),
      (joinedRoom) async {
        final tripId = joinedRoom.tripId;

        final enterResult = await _repository.getEnterTrip(tripId: tripId);

        return enterResult;
      },
    );
  }
}
