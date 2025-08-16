import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/flight_entity.dart';

part 'flight_create_param.freezed.dart';

@freezed
abstract class FlightCreateParam with _$FlightCreateParam {
  const FlightCreateParam._();

  const factory FlightCreateParam({
    @Default("") String flightName,
    FlightEntity? flightEntity,
  }) = _FlightCreateParam;
}
