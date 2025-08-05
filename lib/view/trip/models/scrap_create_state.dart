import 'package:flutter/animation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/core/enum/content_color.dart';
import 'package:tripStory/util/one_time_event.dart';

part 'scrap_create_state.freezed.dart';

@freezed
abstract class ScrapCreateState with _$ScrapCreateState {
  const ScrapCreateState._();

  const factory ScrapCreateState({
    @Default("") String title,
    @Default("") String content,
    @Default(ContentColor.white) ContentColor selectedColor,
    @Default([]) List<String> photoList,
    OneTimeEvent<bool>? showLoading,
  }) = _ScrapCreateState;

  Color get color => selectedColor.color;

  /// 이미지가 있는지 여부
  bool get hasImage => photoList.isNotEmpty;
}
