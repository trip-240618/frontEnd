import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/core/permission/permission_state.dart';
import 'package:tripStory/domain/entities/visited_country_entity.dart';
import 'package:tripStory/util/one_time_event.dart';

part 'my_page_setting_state.freezed.dart';

@freezed
abstract class MyPageSettingState with _$MyPageSettingState {
  const MyPageSettingState._();

  const factory MyPageSettingState({
    @Default(PermissionState.unknown) PermissionState locationPermissionState,
    @Default("") String appVersionText,
  }) = _MyPageSettingState;

  String get locationText => locationPermissionState.label;
}
