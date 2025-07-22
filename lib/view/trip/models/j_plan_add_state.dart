import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/location_entity.dart';

part 'j_plan_add_state.freezed.dart';

@freezed
abstract class JPlanAddState with _$JPlanAddState {
  const JPlanAddState._();

  const factory JPlanAddState({
    DateTime? selectedDate,
    DateTime? selectedTime,
    LocationEntity? searchPlace,
    @Default("") String planTitle,
    @Default("") String planMemo,
  }) = _JPlanAddState;

  bool get planTitleEmpty => planTitle.isEmpty;

  double get searchLatitude => searchPlace?.latitude ?? 0.0;

  double get searchLongitude => searchPlace?.longitude ?? 0.0;
}
