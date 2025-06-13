import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/app/data/models/file_response.dart';

part 'file_client.g.dart';

@RestApi(baseUrl: "https://trip-story.site/file")
abstract class FileClient {
  factory FileClient(Dio dio, {String baseUrl}) = _FileClient;

  @GET("/request/url")
  Future<FileResponse> getFileUrls({
    @Query("prefix") required String prefix,
    @Query("photoCnt") required int photoCnt,
  });
}
