import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/version_data_source.dart';
import 'package:tripStory/data/mappers/version_mapper.dart';
import 'package:tripStory/domain/entities/version_entity.dart' show VersionEntity;
import 'package:tripStory/domain/repositories/version_repository.dart';

class VersionRepositoryImpl implements VersionRepository {
  final AndroidVersionDataSource androidSource;
  final IOSVersionDataSource iosSource;
  final VersionDataSource versionDataSource;

  VersionRepositoryImpl({
    required this.androidSource,
    required this.iosSource,
    required this.versionDataSource,
  });

  @override
  Future<String?> fetchStoreVersion() async {
    try {
      if (Platform.isAndroid) {
        return await androidSource.fetchStoreVersion();
      } else if (Platform.isIOS) {
        return await iosSource.fetchStoreVersion();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  ResultFuture<VersionEntity> fetchLastVersion() async {
    try {
      final result = await versionDataSource.fetchVersionLast();
      final entity = VersionMapper.toEntity(result);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
