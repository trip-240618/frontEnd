import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/air_line_entity.dart';

part 'flight_search_state.freezed.dart';

@freezed
abstract class FlightSearchState with _$FlightSearchState {
  const FlightSearchState._();

  const factory FlightSearchState({
    @Default([]) List<AirLineEntity> airLines,
    AirLineEntity? selectedAirLine,
    @Default("") String airLineText,
  }) = _FlightSearchState;

  int get airLineLength => airLines.length;
}
