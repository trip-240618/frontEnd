import 'package:dartz/dartz.dart';
import 'package:tripStory/core/enum/file_prefix_type.dart';
import 'package:tripStory/core/enum/trip_type.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/core/util/extension/either_extension.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/history_reply_entity.dart';
import 'package:tripStory/domain/entities/trip_room_create_entity.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class CreateReplyParams {
  final int tripId;
  final int historyId;
  final String content;

  const CreateReplyParams({
    required this.tripId,
    required this.historyId,
    required this.content,
  });
}

class CreateReplyUsecase implements UseCase<List<HistoryReplyEntity>, CreateReplyParams> {
  final TripRepository _tripRepository;

  CreateReplyUsecase(
    this._tripRepository,
  );

  @override
  ResultFuture<List<HistoryReplyEntity>> call(CreateReplyParams params) async {
    return await _tripRepository.postReplyCreate(
      tripId: params.tripId,
      historyId: params.historyId,
      content: params.content,
    );
  }
}
