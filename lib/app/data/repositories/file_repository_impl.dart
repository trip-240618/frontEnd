import 'dart:typed_data';

import 'package:tripStory/app/data/models/file_response.dart';
import 'package:tripStory/app/data/providers/file_client.dart';
import 'package:tripStory/app/data/repositories/file_repository.dart';

class FileRepositoryImpl implements FileRepository {
  final FileClient _fileClient;

  FileRepositoryImpl(this._fileClient);

  @override
  Future<FileResponse> getFileUrls({
    required String prefix,
    required int photoCnt,
  }) async {
    return await _fileClient.getFileUrls(
      prefix: prefix,
      photoCnt: photoCnt,
    );
  }

  @override
  Future<void> putUploadImage({
    required String url,
    required Uint8List fileBytes,
  }) async {
    return await _fileClient.putUploadImage(
      url: url,
      fileBytes: fileBytes,
    );
  }
}
