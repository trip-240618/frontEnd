import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/mappers/j_plan_mapper.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/j_plan_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class MoveJPlanLockerUsecase implements UseCase<void, Tuple2<int, JPlanEntity>> {
  final TripRepository repository;

  MoveJPlanLockerUsecase(this.repository);

  @override
  ResultFuture<void> call(Tuple2<int, JPlanEntity> parms) async {
    final modified = parms.value2.copyWith(locker: true);
    final request = JPlanMapper.toModifyRequest(modified);

    return repository.putModifyJPlan(
      tripId: parms.value1,
      request: request,
    );
  }
}
