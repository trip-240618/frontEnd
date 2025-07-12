import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_config_response.freezed.dart';
part 'notification_config_response.g.dart';

@freezed
abstract class NotificationConfigResponse with _$NotificationConfigResponse {
  const factory NotificationConfigResponse({
    required bool activePlan,
    required bool activeLikeReply,
    required bool activeMarketing,
  }) = _NotificationConfigResponse;

  factory NotificationConfigResponse.fromJson(Map<String, dynamic> json) => _$NotificationConfigResponseFromJson(json);
}
