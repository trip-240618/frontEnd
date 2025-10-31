import 'package:dartz/dartz.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/token_repository.dart';

class SkipAppUpdateUsecase implements UseCase<void, NoParams> {
  final TokenRepository repository;

  SkipAppUpdateUsecase(this.repository);

  @override
  ResultFuture<void> call(NoParams params) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      await repository.saveSkippedVersion(currentVersion);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
