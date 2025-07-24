import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/location_entity.dart';

part 'j_plan_create_state.freezed.dart';

@freezed
abstract class JPlanCreateState with _$JPlanCreateState {
  const JPlanCreateState._();

  const factory JPlanCreateState({
    DateTime? selectedDate,
    DateTime? selectedTime,
    LocationEntity? searchPlace,
    @Default("") String planTitle,
    @Default("") String planMemo,
  }) = _JPlanCreateState;

  bool get planTitleEmpty => planTitle.isEmpty;

  double get searchLatitude => searchPlace?.latitude ?? 0.0;

  double get searchLongitude => searchPlace?.longitude ?? 0.0;

  bool get isValid => selectedDate != null && selectedTime != null && planTitle.trim().isNotEmpty;
}
