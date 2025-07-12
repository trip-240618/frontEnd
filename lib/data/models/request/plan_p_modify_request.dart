import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_p_modify_request.freezed.dart';
part 'plan_p_modify_request.g.dart';

@freezed
abstract class PlanPModifyRequest with _$PlanPModifyRequest {
  const factory PlanPModifyRequest({
    required int planId,
    required int dayAfterStart,
    required int orderByDate,
    required String content,
    required bool checkbox,
    required bool locker,
  }) = _PlanPModifyRequest;

  factory PlanPModifyRequest.fromJson(Map<String, dynamic> json) => _$PlanPModifyRequestFromJson(json);
}
