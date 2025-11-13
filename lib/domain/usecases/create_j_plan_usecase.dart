import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/plan_j_create_request.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class CreateJPlanUsecase implements UseCase<void, Tuple2<int, PlanJCreateRequest>> {
  final TripRepository repository;

  CreateJPlanUsecase(this.repository);

  @override
  ResultFuture<void> call(Tuple2<int, PlanJCreateRequest> params) async {
    return repository.postCreateJPlan(
      tripId: params.value1,
      planJCreateRequest: params.value2,
    );
  }
}
