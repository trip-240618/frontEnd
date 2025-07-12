import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_j_response.freezed.dart';
part 'plan_j_response.g.dart';

@freezed
abstract class PlanJResponse with _$PlanJResponse {
  const factory PlanJResponse({
    required int planId,
    required int dayAfterStart,
    required int orderByDate,
    required String startTime,
    required String title,
    required String memo,
    required String place,
    required double latitude,
    required double longitude,
    required bool locker,
  }) = _PlanJResponse;

  factory PlanJResponse.fromJson(Map<String, dynamic> json) => _$PlanJResponseFromJson(json);
}
