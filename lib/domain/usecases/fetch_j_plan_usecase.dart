import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/j_plan_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class FetchJPlanUsecase implements UseCase<List<JPlanEntity>, Tuple3<int, int, bool>> {
  final TripRepository repository;

  FetchJPlanUsecase(this.repository);

  @override
  ResultFuture<List<JPlanEntity>> call(Tuple3<int, int, bool> params) async {
    return await repository.fetchJPlan(
      tripId: params.value1,
      day: params.value2,
      locker: params.value3,
    );
  }
}
