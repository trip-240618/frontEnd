import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/domain/entities/j_plan_entity.dart';
import 'package:tripStory/util/one_time_event.dart';

part 'flight_search_state.freezed.dart';

@freezed
abstract class FlightSearchState with _$FlightSearchState {
  const FlightSearchState._();

  const factory FlightSearchState({
    @Default(0) int selectedDayIndex,
    @Default([]) List<JPlanEntity> plans,
    DateTime? selectedDate,
    @Default(154.0) double googleMapHeight,
    @Default(0.0) double mapLatitude,
    @Default(0.0) double mapLongitude,
    @Default({}) Set<Marker> markers,
    @Default({}) Set<Polyline> polylines,
    OneTimeEvent<String>? showToast,
  }) = _FlightSearchState;
}
