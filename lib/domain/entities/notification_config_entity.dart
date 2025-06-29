import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_config_entity.freezed.dart';

@freezed
abstract class NotificationConfigEntity with _$NotificationConfigEntity {
  const factory NotificationConfigEntity({
    required bool activePlan,
    required bool activeLikeReply,
    required bool activeMarketing,
  }) = _NotificationConfigEntity;
}
