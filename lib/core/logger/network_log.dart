import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class NetworkLog extends Interceptor {
  final Logger logger;

  NetworkLog(this.logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('[REQUEST] ${options.method} ${options.uri}');
    logger.d('Headers: ${_prettify(options.headers)}');

    if (options.queryParameters.isNotEmpty) {
      logger.d('Query Parameters:\n${_prettify(options.queryParameters)}');
    }
    
    if (options.data != null) {
      logger.d('Body:\n${_prettify(options.data)}');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('[RESPONSE] ${response.requestOptions.method} ${response.requestOptions.uri}');
    logger.d('Status: ${response.statusCode}');
    logger.d('Data:\n${_prettify(response.data)}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e('[ERROR] ${err.requestOptions.method} ${err.requestOptions.uri}');
    logger.e('Message: ${err.message}');

    if (err.response != null) {
      logger.w('Status: ${err.response?.statusCode}');
      logger.w('Error Response:\n${_prettify(err.response?.data)}');
    }

    super.onError(err, handler);
  }

  String _prettify(dynamic data) {
    try {
      if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      }
      return data.toString();
    } catch (error) {
      return error.toString();
    }
  }
}
