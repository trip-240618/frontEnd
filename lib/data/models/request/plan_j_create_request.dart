import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_j_create_request.freezed.dart';
part 'plan_j_create_request.g.dart';

@freezed
abstract class PlanJCreateRequest with _$PlanJCreateRequest {
  const factory PlanJCreateRequest({
    required int dayAfterStart,
    required String startTime,
    required String title,
    required String place,
    required String memo,
    required double latitude,
    required double longitude,
    required bool locker,
  }) = _PlanJCreateRequest;

  factory PlanJCreateRequest.fromJson(Map<String, dynamic> json) => _$PlanJCreateRequestFromJson(json);
}
