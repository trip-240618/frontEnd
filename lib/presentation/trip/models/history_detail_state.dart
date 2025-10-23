import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/core/util/models/dialog_info.dart';
import 'package:tripStory/core/util/one_time_event.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/domain/entities/history_reply_entity.dart';

part 'history_detail_state.freezed.dart';

enum HistoryDetailStatus {
  initial,
  empty,
  success,
  loading,
}

@freezed
abstract class HistoryDetailState with _$HistoryDetailState {
  const HistoryDetailState._();

  const factory HistoryDetailState({
    @Default(HistoryDetailStatus.initial) HistoryDetailStatus historyDetailStatus,
    @Default({}) Map<int, HistoryEntity> historyDetailEntities,
    @Default([]) List<HistoryReplyEntity> replies,
    @Default([]) List<int> historyIds,
    OneTimeEvent<DialogInfo>? showDialog,
  }) = _HistoryDetailState;

  int get historiesDetailLength => historyDetailEntities.length;
}
