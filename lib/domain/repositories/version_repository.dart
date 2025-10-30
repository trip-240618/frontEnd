import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/entities/version_entity.dart';

abstract class VersionRepository {
  Future<String?> fetchStoreVersion();

  ResultFuture<VersionEntity> fetchLastVersion();
}
