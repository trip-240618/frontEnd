import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/file_data_source.dart';
import 'package:tripStory/data/datasources/remote/file_upload_data_source.dart';
import 'package:tripStory/data/mappers/file_mapper.dart';
import 'package:tripStory/data/network/cloud_front_file_service.dart';
import 'package:tripStory/domain/entities/file_entity.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';

class FileRepositoryImpl implements FileRepository {
  final FileDataSource _fileDataSource;
  final FileUploadDataSource _fileUploadDataSource;
  final CloudFrontHttpFileService _httpFileService;

  FileRepositoryImpl(
    this._fileDataSource,
    this._fileUploadDataSource,
    this._httpFileService,
  );

  @override
  ResultFuture<FileEntity> fetchFileUrls({
    required String prefix,
    required int count,
  }) async {
    try {
      final response = await _fileDataSource.fetchFileUrls(
        prefix: prefix,
        photoCnt: count,
      );
      final entity = FileMapper.toEntity(response);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<Unit> uploadBytes({
    required String preSignedUrl,
    required List<int> bytes,
    UploadProgress? onSendProgress,
  }) async {
    try {
      await _fileUploadDataSource.putBytes(
        preSignedUrl: preSignedUrl,
        bytes: bytes,
        onSendProgress: onSendProgress,
      );
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> shareImage({
    required String imageUrl,
  }) async {
    try {
      final uri = Uri.parse(imageUrl);
      final response = await _httpFileService.get(uri.toString());
      final bytes = await response.content.toBytes();

      final tempDir = await getTemporaryDirectory();
      final file = File("${tempDir.path}/share_image.jpg");
      await file.writeAsBytes(bytes);

      await Share.shareXFiles([XFile(file.path)]);
      await file.delete();

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
