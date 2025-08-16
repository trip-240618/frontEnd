import 'package:freezed_annotation/freezed_annotation.dart';

part 'alim_setting_state.freezed.dart';

enum AlimSettingStatus { initial, loading, success, failure }

@freezed
abstract class AlimSettingState with _$AlimSettingState {
  const AlimSettingState._();

  const factory AlimSettingState({
    @Default(AlimSettingStatus.initial) AlimSettingStatus status,
    @Default(false) bool isScheduleAlim,
    @Default(false) bool isLikeAlim,
    @Default(false) bool isMarketingAlim,
  }) = _AlimSettingState;
}
