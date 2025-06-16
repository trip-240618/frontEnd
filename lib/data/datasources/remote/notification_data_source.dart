import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/notifications_response.dart';

part 'notification_data_source.g.dart';

@RestApi(baseUrl: "https://trip-story.site/notification")
abstract class NotificationDataSource {
  factory NotificationDataSource(Dio dio, {String baseUrl}) = _NotificationDataSource;

  @GET("/list")
  Future<List<NotificationsResponse>> fetchNotifications(
    @Query("id") int id,
    @Query("title") String? title,
  );
}
