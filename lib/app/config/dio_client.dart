import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  late Dio dio;
  DioClient() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://trip-story.site', // 기본 URL 설정
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final cookie = await getCookies();
        print('?? ${cookie}');
        if (cookie != null) {
          options.headers[HttpHeaders.cookieHeader] = cookie;
        }
        return handler.next(options); // 요청 계속 진행
      },
      onResponse: (response, handler) async {
        final setCookieHeader = response.headers['set-cookie'];
        if(setCookieHeader !=null){
          await saveCookies('${setCookieHeader}');
        }
        return handler.next(response); // 응답 계속 진행
      },
    ));
  }
  /// 쿠키 저장
  Future<void> saveCookies(String cookies) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cookies', cookies);
  }
  ///쿠키 가져오기
  Future<String?> getCookies() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cookies');
  }
  /// 쿠키 삭제
  Future<void> deleteCookies() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cookies');
  }

}
