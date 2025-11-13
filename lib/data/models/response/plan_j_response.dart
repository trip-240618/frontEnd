import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_j_response.freezed.dart';
part 'plan_j_response.g.dart';

@freezed
abstract class PlanJResponse with _$PlanJResponse {
  const factory PlanJResponse({
    required int dayAfterStart,
    required List<PlanResponse> planList,
  }) = _PlanJResponse;

  factory PlanJResponse.fromJson(Map<String, dynamic> json) => _$PlanJResponseFromJson(json);
}

@freezed
abstract class PlanResponse with _$PlanResponse {
  const factory PlanResponse({
    required int planId,
    required int dayAfterStart,
    required int orderByDate,
    required String startTime,
    required String title,
    String? memo,
    String? place,
    double? latitude,
    double? longitude,
    required bool locker,
  }) = _PlanResponse;

  factory PlanResponse.fromJson(Map<String, dynamic> json) => _$PlanResponseFromJson(json);
}
