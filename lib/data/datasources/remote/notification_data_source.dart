import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/request/notification_config_modify_request.dart';
import 'package:tripStory/data/models/response/notification_config_response.dart';
import 'package:tripStory/data/models/response/notifications_response.dart';

part 'notification_data_source.g.dart';

@RestApi(baseUrl: "/notification")
abstract class NotificationDataSource {
  factory NotificationDataSource(Dio dio, {String baseUrl}) = _NotificationDataSource;

  @GET("/list")
  Future<List<NotificationsResponse>> fetchNotifications(
    @Query("id") int id,
    @Query("title") String? title,
  );

  @GET("/config")
  Future<NotificationConfigResponse> fetchNotificationConfig();

  @PUT("/config/modify")
  Future<NotificationConfigResponse> putNotificationConfig(
    @Body() NotificationConfigModifyRequest request,
  );
}
