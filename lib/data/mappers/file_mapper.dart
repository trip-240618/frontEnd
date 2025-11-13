import 'package:tripStory/data/models/response/file_response.dart';
import 'package:tripStory/domain/entities/file_entity.dart';

class FileMapper {
  static FileEntity toEntity(FileResponse response) {
    return FileEntity(
      preSignedUrls: response.preSignedUrls,
    );
  }
}
