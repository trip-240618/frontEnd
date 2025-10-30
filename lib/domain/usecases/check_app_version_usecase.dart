import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tripStory/core/enum/app_update_type.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/token_repository.dart';
import 'package:tripStory/domain/repositories/version_repository.dart';

class CheckAppVersionUsecase implements UseCase<AppUpdateType, NoParams> {
  final VersionRepository repository;
  final TokenRepository tokenRepository;

  CheckAppVersionUsecase(
    this.repository,
    this.tokenRepository,
  );

  @override
  ResultFuture<AppUpdateType> call(NoParams params) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      final versionResult = await repository.fetchLastVersion();

      return versionResult.fold(
        (failure) => const Right(AppUpdateType.optionalUpdate),
        (versionEntity) async {
          final forceUpdateVersion = Platform.isAndroid ? versionEntity.androidVersion : versionEntity.iosVersion;
          final isForceUpdateEnabled = versionEntity.forceUpdate;

          final storeVersion = await repository.fetchStoreVersion();

          if (storeVersion == null || storeVersion.isEmpty) {
            return const Right(AppUpdateType.unknown);
          }
          if (isForceUpdateEnabled && _compareVersion(currentVersion, forceUpdateVersion) < 0) {
            final skippedVersion = await tokenRepository.getSkippedVersion();

            if (skippedVersion == storeVersion) {
              return const Right(AppUpdateType.upToDate);
            }
            return const Right(AppUpdateType.forceUpdate);
          }
          if (_compareVersion(currentVersion, storeVersion) < 0) {
            return const Right(AppUpdateType.optionalUpdate);
          }
          return const Right(AppUpdateType.upToDate);
        },
      );
    } catch (e) {
      return const Right(AppUpdateType.unknown);
    }
  }

  int _compareVersion(String local, String store) {
    final localParts = local.split('.').map(int.parse).toList();
    final storeParts = store.split('.').map(int.parse).toList();

    for (int i = 0; i < storeParts.length; i++) {
      if (i >= localParts.length) return -1;
      if (localParts[i] < storeParts[i]) return -1;
      if (localParts[i] > storeParts[i]) return 1;
    }
    return 0;
  }
}
