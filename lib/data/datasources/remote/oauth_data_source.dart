import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/apple_login_request.dart';
import 'package:tripStory/data/models/user_request.dart';
import 'package:tripStory/data/models/user_response.dart';

part 'oauth_data_source.g.dart';

@RestApi(baseUrl: "https://trip-story.site/user/oauth2")
abstract class OauthDataSource {
  factory OauthDataSource(Dio dio, {String baseUrl}) = _OauthDataSource;

  @GET("/callback/kakao")
  Future<UserResponse> fetchKakaoUserInfo(
    @Query("kakaoToken") String kakaoToken,
    @Query("fcmToken") String fcmToken,
  );

  @POST("/login/google")
  Future<UserResponse> postGoogleUserInfo(
    @Body() UserRequest request,
  );

  @POST("/login/apple")
  Future<UserResponse> postAppleUserInfo(
    @Body() AppleLoginRequest request,
  );
}
