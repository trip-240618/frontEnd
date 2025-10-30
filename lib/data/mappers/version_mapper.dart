import 'package:tripStory/data/models/response/version_response.dart';
import 'package:tripStory/domain/entities/version_entity.dart';

class VersionMapper {
  static VersionEntity toEntity(VersionResponse response) {
    return VersionEntity(
      id: response.id,
      androidVersion: response.androidVersion,
      iosVersion: response.iosVersion,
      forceUpdate: response.forceUpdate,
      createDate: response.createDate,
    );
  }
}
