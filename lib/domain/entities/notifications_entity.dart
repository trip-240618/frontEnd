import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_entity.freezed.dart';

@freezed
abstract class NotificationsEntity with _$NotificationsEntity {
  const factory NotificationsEntity({
    required int id,
    required String labelColor,
    required String destination,
    required String title,
    required String content,
    required DateTime createDate,
    required bool read,
  }) = _NotificationsEntity;
}
