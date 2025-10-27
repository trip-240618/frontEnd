import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/presentation/trip/models/history_search_param.dart';

class FetchSearchHistoryUsecase implements UseCase<List<HistoryEntity>, Tuple2<int, HistorySearchParam>> {
  final TripRepository repository;

  FetchSearchHistoryUsecase(this.repository);

  @override
  ResultFuture<List<HistoryEntity>> call(Tuple2<int, HistorySearchParam> params) async {
    return switch (params.value2) {
      TagSearchParam(:final tag) => repository.fetchSearchHistories(
          tripId: params.value1,
          tagName: tag.tagName,
          tagColor: tag.tagColor,
        ),
      MemberSearchParam(:final member) => repository.fetchSearchHistories(
          tripId: params.value1,
          uuid: member.uuid,
        ),
    };
  }
}
