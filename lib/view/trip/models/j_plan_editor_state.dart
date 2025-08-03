import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/location_entity.dart';

part 'j_plan_editor_state.freezed.dart';

@freezed
abstract class JPlanEditorState with _$JPlanEditorState {
  const JPlanEditorState._();

  const factory JPlanEditorState({
    DateTime? selectedDate,
    DateTime? selectedTime,
    LocationEntity? searchPlace,
    @Default("") String planTitle,
    @Default("") String planMemo,
  }) = _JPlanEditorState;

  bool get planTitleEmpty => planTitle.isEmpty;

  double get searchLatitude => searchPlace?.latitude ?? 0.0;

  double get searchLongitude => searchPlace?.longitude ?? 0.0;

  bool get isValid => selectedDate != null && selectedTime != null && planTitle.trim().isNotEmpty;
}
