import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/file_data_source.dart';
import 'package:tripStory/data/mappers/file_mapper.dart';
import 'package:tripStory/data/models/file_request.dart';
import 'package:tripStory/domain/entities/file_entity.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';

class FileRepositoryImpl implements FileRepository {
  final FileDataSource _fileDataSource;

  FileRepositoryImpl(this._fileDataSource);

  @override
  ResultFuture<FileEntity> fetchFileUrls(FileRequest request) async {
    try {
      final response = await _fileDataSource.fetchFileUrls(
        prefix: request.prefix,
        photoCnt: request.photoCnt,
      );
      final entity = FileMapper.toEntity(response);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
