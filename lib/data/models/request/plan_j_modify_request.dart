import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_j_modify_request.freezed.dart';
part 'plan_j_modify_request.g.dart';

@freezed
abstract class PlanJModifyRequest with _$PlanJModifyRequest {
  const factory PlanJModifyRequest({
    required int planId,
    required int dayAfterStart,
    required int orderByDate,
    required String startTime,
    required String title,
    String? place,
    String? memo,
    double? latitude,
    double? longitude,
    required bool locker,
  }) = _PlanJModifyRequest;

  factory PlanJModifyRequest.fromJson(Map<String, dynamic> json) => _$PlanJModifyRequestFromJson(json);
}
