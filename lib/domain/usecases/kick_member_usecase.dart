import 'package:tripStory/core/enum/trip_type.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class KickMemberParams {
  final int tripId;
  final TripType tripType;
  final String uuid;

  const KickMemberParams({
    required this.tripId,
    required this.tripType,
    required this.uuid,
  });
}

class KickMemberUsecase implements UseCase<void, KickMemberParams> {
  final TripRepository _repository;

  KickMemberUsecase(this._repository);

  @override
  ResultFuture<void> call(KickMemberParams params) async {
    return await _repository.deleteKickMember(
      tripId: params.tripId,
      tripType: params.tripType.name,
      uuid: params.uuid,
    );
  }
}
