import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/response/notice_list_response.dart';

part 'notice_data_source.g.dart';

@RestApi(baseUrl: "/notice")
abstract class NoticeDataSource {
  factory NoticeDataSource(Dio dio, {String baseUrl}) = _NoticeDataSource;

  @GET("/list")
  Future<List<NoticeListResponse>> fetchNotices(
    @Query("type") String type,
  );
}
