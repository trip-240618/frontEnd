import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_p_edit_request.freezed.dart';
part 'plan_p_edit_request.g.dart';

@freezed
abstract class PlanPEditRequest with _$PlanPEditRequest {
  const factory PlanPEditRequest({
    required int week,
    required List<PlanPDayList> dayList,
  }) = _PlanPEditRequest;

  factory PlanPEditRequest.fromJson(Map<String, dynamic> json) => _$PlanPEditRequestFromJson(json);
}

@freezed
abstract class PlanPDayList with _$PlanPDayList {
  const factory PlanPDayList({
    required int day,
    required List<PlanPPlanList> planList,
  }) = _PlanPDayList;

  factory PlanPDayList.fromJson(Map<String, dynamic> json) => _$PlanPDayListFromJson(json);
}

@freezed
abstract class PlanPPlanList with _$PlanPPlanList {
  const factory PlanPPlanList({
    required int id,
    required int dayAfterStart,
    required int orderByDate,
  }) = _PlanPPlanList;

  factory PlanPPlanList.fromJson(Map<String, dynamic> json) => _$PlanPPlanListFromJson(json);
}
