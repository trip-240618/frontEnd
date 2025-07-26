import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class DeleteJPlanUsecase implements UseCase<void, Tuple3<int, int, int>> {
  final TripRepository repository;

  DeleteJPlanUsecase(this.repository);

  @override
  ResultFuture<void> call(Tuple3<int, int, int> params) async {
    return repository.deleteJPlan(
      tripId: params.value1,
      planId: params.value2,
      day: params.value3,
    );
  }
}
