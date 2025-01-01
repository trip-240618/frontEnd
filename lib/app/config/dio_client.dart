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
        final prefs = await SharedPreferences.getInstance();
        String accessToken = '${prefs.getString('accessToken')}';
        String refreshToken = '${prefs.getString('refreshToken')}';
        if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
          options.headers[HttpHeaders.cookieHeader] = '${accessToken};${refreshToken}';
        }
        return handler.next(options); // 요청 계속 진행
      },
      onResponse: (response, handler) async {
        final setCookieHeader = response.headers['set-cookie'];
        if(setCookieHeader != null){
          await saveAccessToken('${response.headers['set-cookie']![0]}');
        }
        return handler.next(response); // 응답 계속 진행
      },
      onError: (error, handler) {
        return handler.next(error);
        /// 리프레쉬 토큰 만료 토큰
        if(error.response?.statusCode == 420){
          print('새로운 토큰 갱신 후 실패했던 api 다시 진행');
        }
      },
    ));
  }

  /// 로그인 할 때 엑세스토큰,리프리쉬 토큰 저장
  Future<void> loginCookies(String cookies) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken','${cookies.toString().split(',')[0]}');
    await prefs.setString('refreshToken','${cookies.toString().split(',')[1]}');
  }
  /// 응답값 보낼 엑세스 토큰 갱신
  Future<void> saveAccessToken(String cookies) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken','${cookies.toString().split(',')[0]}');
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
