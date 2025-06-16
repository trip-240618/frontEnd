import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/file_request.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/file_entity.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';

class FetchPresignedUrlUsecase implements UseCase<FileEntity, FileRequest> {
  final FileRepository repository;

  FetchPresignedUrlUsecase(this.repository);

  @override
  ResultFuture<FileEntity> call(FileRequest params) {
    return repository.fetchFileUrls(params);
  }
}
