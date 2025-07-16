import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';

part 'trip_main_state.freezed.dart';

enum TripMainStatus { initial, loading, success, failure }

enum TripNaviType {
  plan,
  locker,
  history;

  String get title {
    switch (this) {
      case TripNaviType.plan:
        return "여행 일정";
      case TripNaviType.locker:
        return "보관함";
      case TripNaviType.history:
        return "여행 기록";
    }
  }

  String get iconPath {
    switch (this) {
      case TripNaviType.plan:
        return IconConstants.calendar;
      case TripNaviType.locker:
        return IconConstants.inbox;
      case TripNaviType.history:
        return IconConstants.photo;
    }
  }
}

@freezed
abstract class TripMainState with _$TripMainState {
  const TripMainState._();

  const factory TripMainState({
    @Default(TripMainStatus.initial) TripMainStatus status,
    @Default(TripNaviType.plan) TripNaviType selectedTripType,
  }) = _TripMainState;

  int get selectedTabIndex => selectedTripType.index;
}
