import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tripStory/core/services/session_service.dart';
import 'package:tripStory/data/network/cloud_front_file_service.dart';

class CustomCacheManager extends CacheManager {
  static const key = 'customCacheKey';

  static CustomCacheManager? _instance;

  factory CustomCacheManager(SessionService sessionService) {
    _instance ??= CustomCacheManager._(sessionService);
    return _instance!;
  }

  CustomCacheManager._(SessionService sessionService)
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 1),
            maxNrOfCacheObjects: 100,
            fileService: CloudFrontHttpFileService(sessionService),
          ),
        );
}
