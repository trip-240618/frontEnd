import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/file_request.dart';
import 'package:tripStory/domain/entities/file_entity.dart';

abstract class FileRepository {
  ResultFuture<FileEntity> fetchFileUrls(FileRequest fileRequest);
}
