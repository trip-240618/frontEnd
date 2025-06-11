import 'package:dio/dio.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/app/data/models/file_response.dart';

class FileClient {
  final Dio _dio;

  FileClient(DioClient dioClient) : _dio = dioClient.dio;

  Future<FileResponse> getFileUrls({
    required String prefix,
    required int photoCnt,
  }) async {
    final response = await _dio.get(
      '/file/request/url',
      queryParameters: {
        'prefix': prefix,
        'photoCnt': photoCnt,
      },
    );
    return FileResponse.fromJson(response.data);
  }
}
