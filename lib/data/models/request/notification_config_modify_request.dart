import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_config_modify_request.freezed.dart';
part 'notification_config_modify_request.g.dart';

@freezed
abstract class NotificationConfigModifyRequest with _$NotificationConfigModifyRequest {
  const factory NotificationConfigModifyRequest({
    required bool activePlan,
    required bool activeLikeReply,
    required bool activeMarketing,
  }) = _NotificationConfigModifyRequest;

  factory NotificationConfigModifyRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationConfigModifyRequestFromJson(json);
}
