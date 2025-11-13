import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_p_plan_response.freezed.dart';
part 'trip_p_plan_response.g.dart';

@freezed
abstract class TripPPlanResponse with _$TripPPlanResponse {
  const factory TripPPlanResponse({
    required int week,
    required List<TripPPlanDayList> dayList,
  }) = _TripPPlanResponse;

  factory TripPPlanResponse.fromJson(Map<String, dynamic> json) => _$TripPPlanResponseFromJson(json);
}

@freezed
abstract class TripPPlanDayList with _$TripPPlanDayList {
  const factory TripPPlanDayList({
    required int day,
    required List<TripPPlanList> planList,
  }) = _TripPPlanDayList;

  factory TripPPlanDayList.fromJson(Map<String, dynamic> json) => _$TripPPlanDayListFromJson(json);
}

@freezed
abstract class TripPPlanList with _$TripPPlanList {
  const factory TripPPlanList({
    required int planId,
    required int dayAfterStart,
    required int orderByDate,
    required String content,
    required bool checkbox,
    required bool locker,
  }) = _TripPPlanList;

  factory TripPPlanList.fromJson(Map<String, dynamic> json) => _$TripPPlanListFromJson(json);
}
