import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripStory/app/data/log/network_log.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  late final Dio dio;
  final logger = Logger();

  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://trip-story.site',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));

    dio.interceptors.add(NetworkLog(logger));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final accessToken = prefs.getString('accessToken') ?? "";
        final refreshToken = prefs.getString('refreshToken') ?? "";
        if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
          options.headers[HttpHeaders.cookieHeader] = '$accessToken;$refreshToken';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        final setCookieHeader = response.headers['set-cookie'];
        if (setCookieHeader != null) {
          await saveAccessToken(setCookieHeader.first);
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }

  /// 로그인 할 때 엑세스토큰,리프리쉬 토큰 저장
  Future<void> loginCookies(String cookies) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', '${cookies.toString().split(',')[0]}');
    await prefs.setString('refreshToken', '${cookies.toString().split(',')[1]}');
  }

  /// 응답값 보낼 엑세스 토큰 갱신
  Future<void> saveAccessToken(String cookies) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', '${cookies.toString().split(',')[0]}');
  }

  ///엑세스 토큰 리프레쉬 토큰 가져오기
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  /// 쿠키 삭제
  Future<void> deleteCookies() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }
}
