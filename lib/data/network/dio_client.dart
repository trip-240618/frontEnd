import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:tripStory/core/logger/network_log.dart';
import 'package:tripStory/data/datasources/local/token_storage.dart';

class DioClient {
  final TokenStorage tokenStorage;
  final Dio dio;
  final logger = Logger();

  DioClient({
    required this.tokenStorage,
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
        final tokens = await tokenStorage.getTokens();
        final accessToken = tokens['accessToken'];
        final refreshToken = tokens['refreshToken'];
        if ((accessToken?.isNotEmpty ?? false) && (refreshToken?.isNotEmpty ?? false)) {
          options.headers[HttpHeaders.cookieHeader] = 'accessToken=$accessToken; refreshToken=$refreshToken';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        final setCookieHeader = response.headers['set-cookie'];
        if (setCookieHeader != null && setCookieHeader.isNotEmpty) {
          final cookies = _parseSetCookieHeader(setCookieHeader.first);
          final accessToken = cookies['accessToken'];
          final refreshToken = cookies['refreshToken'];

          if (accessToken != null && refreshToken != null) {
            await tokenStorage.saveTokens(accessToken, refreshToken);
          } else if (accessToken != null) {
            await tokenStorage.saveAccessToken(accessToken);
          }
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }

  Map<String, String> _parseSetCookieHeader(String rawHeader) {
    final Map<String, String> cookies = {};
    final cookieParts = rawHeader.split(RegExp(r',(?! )'));
    for (var part in cookieParts) {
      final kv = part.split(';').first.trim().split('=');
      if (kv.length == 2) {
        cookies[kv[0].trim()] = kv[1].trim();
      }
    }
    return cookies;
  }
}
