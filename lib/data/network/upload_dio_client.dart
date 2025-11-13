import 'package:dio/dio.dart';

class UploaderDioClient {
  final Dio dio;

  UploaderDioClient()
      : dio = Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(minutes: 2),
          receiveTimeout: const Duration(minutes: 2),
        ));
}
