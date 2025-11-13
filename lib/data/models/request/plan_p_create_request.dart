import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_p_create_request.freezed.dart';
part 'plan_p_create_request.g.dart';

@freezed
abstract class PlanPCreateRequest with _$PlanPCreateRequest {
  const factory PlanPCreateRequest({
    required int planId,
    required int dayAfterStart,
    required int orderByDate,
    required String content,
    required bool checkbox,
    required bool locker,
  }) = _PlanPCreateRequest;

  factory PlanPCreateRequest.fromJson(Map<String, dynamic> json) => _$PlanPCreateRequestFromJson(json);
}
