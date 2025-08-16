import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/notice_list_entity.dart';

part 'notices_list_state.freezed.dart';

enum NoticesType {
  all,
  normal,
  update,
  system;

  String get displayName {
    switch (this) {
      case NoticesType.all:
        return "전체";
      case NoticesType.normal:
        return "일반";
      case NoticesType.update:
        return "업데이트";
      case NoticesType.system:
        return "시스템";
    }
  }
}

@freezed
abstract class NoticesListState with _$NoticesListState {
  const NoticesListState._();

  const factory NoticesListState({
    @Default(NoticesType.all) NoticesType selectedNoticesType,
    @Default([]) List<NoticeListEntity> notices,
  }) = _NoticesListState;

  int get noticesLength => notices.length;
}
