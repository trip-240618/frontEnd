import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/air_line_entity.dart';

part 'flight_search_state.freezed.dart';

enum FlightSearchStatus {
  initial,
  empty,
  success,
}

@freezed
abstract class FlightSearchState with _$FlightSearchState {
  const FlightSearchState._();

  const factory FlightSearchState({
    @Default(FlightSearchStatus.initial) FlightSearchStatus flightSearchStatus,
    @Default([]) List<AirLineEntity> airLines,
    DateTime? departureDate,
    AirLineEntity? selectedAirLine,
    @Default("") String airLineNumber,
  }) = _FlightSearchState;

  int get airLineLength => airLines.length;

  bool get isValid => selectedAirLine != null && departureDate != null && airLineNumber.isNotEmpty;
}
