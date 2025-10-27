import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/tag_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class FetchHistoryTagsUsecase implements UseCase<List<TagEntity>, int> {
  final TripRepository repository;

  FetchHistoryTagsUsecase(this.repository);

  @override
  ResultFuture<List<TagEntity>> call(int tripId) async {
    return repository.fetchTags(
      tripId: tripId,
    );
  }
}
