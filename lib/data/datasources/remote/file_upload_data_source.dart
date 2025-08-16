import 'package:dio/dio.dart';

class FileUploadDataSource {
  final Dio _dio;

  FileUploadDataSource(this._dio);

  Future<void> putBytes({
    required String preSignedUrl,
    required List<int> bytes,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    await _dio.put(
      preSignedUrl,
      data: bytes,
      options: Options(
        headers: {
          "Content-Type": "image/jpeg",
        },
      ),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
    );
  }
}
