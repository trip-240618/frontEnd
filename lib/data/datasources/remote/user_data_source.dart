import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/request/register_request.dart';
import 'package:tripStory/data/models/request/user_modify_request.dart';
import 'package:tripStory/data/models/response/user_response.dart';

part 'user_data_source.g.dart';

@RestApi(baseUrl: "/user")
abstract class UserDataSource {
  factory UserDataSource(Dio dio, {String baseUrl}) = _UserDataSource;

  @PUT("/register")
  Future<UserResponse> putUserRegister(
    @Body() RegisterRequest request,
  );

  @GET("/info")
  Future<UserResponse> fetchUserInfo();

  @DELETE("/delete/account")
  Future<void> deleteUser();

  @PUT("/modify")
  Future<UserResponse> putUserModify(
    @Body() UserModifyRequest request,
  );

  @PUT("/update/fcmToken")
  Future<void> updateFcmToken(
    @Query("fcmToken") String fcmToken,
  );
}
