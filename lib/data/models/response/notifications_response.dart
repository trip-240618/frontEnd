import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_response.freezed.dart';
part 'notifications_response.g.dart';

@freezed
abstract class NotificationsResponse with _$NotificationsResponse {
  const factory NotificationsResponse({
    required int id,
    required String labelColor,
    required String destination,
    required String title,
    required String content,
    required String createDate,
    required bool read,
  }) = _NotificationsResponse;

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) => _$NotificationsResponseFromJson(json);
}
