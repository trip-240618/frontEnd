import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/mappers/j_plan_swap_mapper.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/j_plan_swap_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class JPlanSwapUsecase implements UseCase<void, Tuple2<int, JPlanSwapEntity>> {
  final TripRepository repository;

  JPlanSwapUsecase(this.repository);

  @override
  ResultFuture<void> call(Tuple2<int, JPlanSwapEntity> params) async {
    final int tripId = params.value1;
    final JPlanSwapEntity entity = params.value2;

    final request = JPlanSwapMapper.toRequestModel(entity);

    return repository.putSwapJPlan(
      tripId: tripId,
      request: request,
    );
  }
}
