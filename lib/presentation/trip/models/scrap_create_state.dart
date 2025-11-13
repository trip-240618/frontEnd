import 'package:flutter/animation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/core/enum/trip_color.dart';
import 'package:tripStory/core/util/one_time_event.dart';

part 'scrap_create_state.freezed.dart';

@freezed
abstract class ScrapCreateState with _$ScrapCreateState {
  const ScrapCreateState._();

  const factory ScrapCreateState(
      {@Default("") String title,
      @Default("") String content,
      @Default(TripColor.pastelBlue) TripColor selectedColor,
      @Default([]) List<String> photoList,
      @Default(false) bool isShowColorPicker,
      OneTimeEvent<bool>? showLoading,
      XFile? scrapImage}) = _ScrapCreateState;

  Color get getColor => selectedColor.color;

  /// 이미지가 있는지 여부
  bool get hasImage => photoList.isNotEmpty;
}
