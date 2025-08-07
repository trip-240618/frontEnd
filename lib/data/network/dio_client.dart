import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:tripStory/core/logger/network_log.dart';
import 'package:tripStory/core/services/session_service.dart';

class DioClient {
  final SessionService sessionService;
  final Dio dio;
  final logger = Logger();

  DioClient({
    required this.sessionService,
  }) : dio = Dio(BaseOptions(
          baseUrl: "https://tripstory.shop",
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
          headers: {
            "Content-Type": "application/json",
          },
        )) {
    dio.interceptors.add(NetworkLog(logger));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final tokens = await sessionService.getTokens();
        final accessToken = tokens["accessToken"];
        final refreshToken = tokens["refreshToken"];

        if ((accessToken?.isNotEmpty ?? false) && (refreshToken?.isNotEmpty ?? false)) {
          options.headers[HttpHeaders.cookieHeader] = "accessToken=$accessToken; refreshToken=$refreshToken";
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        print("???? ${response}");
        final setCookieHeader = response.headers["set-cookie"];
        if (setCookieHeader != null && setCookieHeader.isNotEmpty) {
          await sessionService.handleSetCookieHeader(setCookieHeader);
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }
}
