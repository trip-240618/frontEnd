import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/domain/entities/j_plan_entity.dart';
import 'package:tripStory/util/one_time_event.dart';

part 'j_plan_state.freezed.dart';

enum JPlanStatus { initial, loading, success, failure }

@freezed
abstract class JPlanState with _$JPlanState {
  const JPlanState._();

  const factory JPlanState({
    @Default(JPlanStatus.initial) JPlanStatus jPlanStatus,
    @Default(0) int selectedDayIndex,
    @Default([]) List<JPlanEntity> plans,
    DateTime? selectedDate,
    @Default(154.0) double googleMapHeight,
    @Default(0.0) double mapLatitude,
    @Default(0.0) double mapLongitude,
    @Default({}) Set<Marker> markers,
    @Default({}) Set<Polyline> polylines,
    OneTimeEvent<String>? showWaitToast,
  }) = _TripMainStateJPlanState;

  int get selectedDay => selectedDayIndex + 1;

  int get plansLength => plans.length;
}
