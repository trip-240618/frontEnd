import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/register_request.dart';
import 'package:tripStory/data/models/user_response.dart';

part 'user_data_source.g.dart';

@RestApi(baseUrl: "https://trip-story.site/user")
abstract class UserDataSource {
  factory UserDataSource(Dio dio, {String baseUrl}) = _UserDataSource;

  @PUT("/register")
  Future<UserResponse> putUserRegister(
    @Body() RegisterRequest request,
  );
}
