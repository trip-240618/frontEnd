import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String kakaoNativeAppKey = dotenv.env["KAKAO_NATIVE_APP_KEY"]!;
  static final String kakaoJavaScriptAppKey = dotenv.env["KAKAO_JAVASCRIPT_APP_KEY"]!;
  static final String kakaoShareTemplateId = dotenv.env["KAKAO_SHARE_ID"]!;
  static final String baseUrl = dotenv.env["BASE_URL"]!;
  static final String privacyPolicy = '$baseUrl${dotenv.env["PRIVACY_POLICY"]}';
  static final String termsOfService = '$baseUrl${dotenv.env['TERMS_POLICY']}';
  static final String socketUrl = dotenv.env["SOCKET_URL"]!;
}
