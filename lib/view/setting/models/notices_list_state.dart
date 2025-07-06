import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/notice_list_entity.dart';

part 'notices_list_state.freezed.dart';

enum NoticesType { all, normal, update, system }

@freezed
abstract class NoticesListState with _$NoticesListState {
  const NoticesListState._();

  const factory NoticesListState({
    @Default(NoticesType.all) NoticesType selectedNoticesType,
    @Default([]) List<NoticeListEntity> notices,
  }) = _NoticesListState;
}
