import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class FetchHistoriesUsecase implements UseCase<List<HistoriesEntity>, int> {
  final TripRepository repository;

  FetchHistoriesUsecase(this.repository);

  @override
  ResultFuture<List<HistoriesEntity>> call(int tripId) async {
    return await repository.fetchHistories(tripId: tripId);
  }
}
