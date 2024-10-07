import 'dio_client.dart';
import 'package:dio/dio.dart';

abstract class BaseApi {
  final DioClient client;
  BaseApi(this.client);

  Future<dynamic> get(
      String path,
      {Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? pathParameters,
        Map<String, String>? headers,
        dynamic data,
        bool extractData = true,
        bool showDialog = true}) async {
    final response = await client.dio.get(
      _bindPathParams(path, pathParameters),
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return handleResponse(response, extractData: extractData, showDialog: showDialog);
  }

  Future<dynamic> post(String path,
      {dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? pathParameters,
        Map<String, String>? headers,
        bool extractData = true,
        bool showDialog = true,
        ProgressCallback? onSendProgress}) async {
    final response = await client.dio.post(
      _bindPathParams(path, pathParameters),
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
      onSendProgress: onSendProgress,
    );
    return handleResponse(response, extractData: extractData, showDialog: showDialog);
  }

  String _bindPathParams(String path, Map<String, dynamic>? params) {
    if (params != null) {
      for (var param in params.entries) {
        path = path.replaceAll("{${param.key}}", param.value.toString());
      }
    }
    return path;
  }

  dynamic handleResponse(Response response, {bool extractData = true, bool showDialog = true}) {
    final statusCode = response.statusCode ?? 0;
    if (statusCode == 200) {
      if (extractData) {
        return response.data["data"] ?? response.data;
      } else {
        return response.data;
      }
    } else {
      if (showDialog) {
        // 에러 메시지 처리 (AlertDialog 표시)
      }
      throw Exception('API Error: $statusCode');
    }
  }
}
