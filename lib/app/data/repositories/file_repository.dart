import 'dart:typed_data';

import 'package:tripStory/app/data/models/file_response.dart';

abstract class FileRepository {
  Future<FileResponse> getFileUrls({
    required String prefix,
    required int photoCnt,
  });

  Future<void> putUploadImage({
    required String url,
    required Uint8List fileBytes,
  });
}
