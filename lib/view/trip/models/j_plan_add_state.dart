import 'package:freezed_annotation/freezed_annotation.dart';

part 'j_plan_add_state.freezed.dart';

@freezed
abstract class JPlanAddState with _$JPlanAddState {
  const JPlanAddState._();

  const factory JPlanAddState({
    DateTime? selectedDate,
    DateTime? selectedTime,
    @Default([]) List searchPlace,
    @Default("") String planTitle,
    @Default("") String planMemo,
  }) = _JPlanAddState;
}
