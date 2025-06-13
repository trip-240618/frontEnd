import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
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
      "/file/request/url",
      queryParameters: {
        "prefix": prefix,
        "photoCnt": photoCnt,
      },
    );
    return FileResponse.fromJson(response.data);
  }

  @override
  Future<void> putUploadImage({
    required String url,
    required Uint8List fileBytes,
  }) async {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Content-Type": "image/jpeg",
      },
      body: fileBytes,
    );
    // TODO: 레트로핏 적용 예정
    if (response.statusCode != 200) {
      throw Exception("");
    }
  }
}
