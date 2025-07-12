import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_p_move_request.freezed.dart';
part 'plan_p_move_request.g.dart';

@freezed
abstract class PlanPMoveRequest with _$PlanPMoveRequest {
  const factory PlanPMoveRequest({
    required int planId,
    required int dayAfterStart,
    required int orderByDate,
    required String content,
    required bool checkbox,
    required bool locker,
  }) = _PlanPMoveRequestt;

  factory PlanPMoveRequest.fromJson(Map<String, dynamic> json) => _$PlanPMoveRequestFromJson(json);
}
