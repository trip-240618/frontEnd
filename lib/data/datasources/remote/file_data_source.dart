import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/response/file_response.dart';

part 'file_data_source.g.dart';

@RestApi(baseUrl: "/file")
abstract class FileDataSource {
  factory FileDataSource(Dio dio, {String baseUrl}) = _FileDataSource;

  @GET("/request/url")
  Future<FileResponse> fetchFileUrls({
    @Query("prefix") required String prefix,
    @Query("photoCnt") required int photoCnt,
  });
}
