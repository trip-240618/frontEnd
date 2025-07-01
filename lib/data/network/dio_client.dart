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
          baseUrl: "https://trip-story.site",
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
        final setCookieHeader = response.headers["set-cookie"];
        if (setCookieHeader != null && setCookieHeader.isNotEmpty) {
          final cookies = _parseSetCookieHeader(setCookieHeader);
          final accessToken = cookies["accessToken"];
          final refreshToken = cookies["refreshToken"];

          if (accessToken != null && refreshToken != null) {
            await sessionService.saveTokens(accessToken, refreshToken);
          } else if (accessToken != null) {
            await sessionService.saveTokens(accessToken, (await sessionService.getTokens())["refreshToken"] ?? "");
          }
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }

  Map<String, String> _parseSetCookieHeader(List<String> rawHeaders) {
    final Map<String, String> cookies = {};

    for (var raw in rawHeaders) {
      final parts = raw.split(";").first.trim().split("=");
      if (parts.length == 2) {
        final key = parts[0].trim();
        final value = parts[1].trim();
        cookies[key] = value;
      }
    }

    return cookies;
  }
}
