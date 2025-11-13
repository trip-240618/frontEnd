import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/data/models/request/location_auto_request.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/auto_location_entity.dart';
import 'package:tripStory/domain/repositories/location_repository.dart';

class PostAutoCompleteUseCase implements UseCase<List<AutoLocationEntity>, LocationAutoRequest> {
  final LocationRepository repository;

  PostAutoCompleteUseCase(this.repository);

  @override
  Future<Either<Failure, List<AutoLocationEntity>>> call(LocationAutoRequest params) {
    return repository.postAutoComplete(params);
  }
}
