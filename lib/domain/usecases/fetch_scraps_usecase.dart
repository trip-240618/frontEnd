import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/scrap_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class FetchScrapsUseCase implements UseCase<List<ScrapEntity>, int> {
  final TripRepository repository;

  FetchScrapsUseCase(this.repository);

  @override
  ResultFuture<List<ScrapEntity>> call(int tripId) async {
    return await repository.fetchScraps(tripId: tripId);
  }
}
