import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/entities/file_entity.dart';

typedef UploadProgress = void Function(int sent, int total);

abstract class FileRepository {
  ResultFuture<FileEntity> fetchFileUrls({
    required String prefix,
    required int count,
  });

  ResultFuture<Unit> uploadBytes({
    required String preSignedUrl,
    required List<int> bytes,
    UploadProgress? onSendProgress,
  });

  ResultFuture<void> shareImage({
    required String imageUrl,
  });
}
