import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';

part 'history_list_state.freezed.dart';

enum HistoryListStatus { initial, loading, success, failure }

@freezed
abstract class HistoryListState with _$HistoryListState {
  const HistoryListState._();

  const factory HistoryListState({
    HistoriesEntity? historyEntity,
    @Default(0) int day,
    @Default(HistoryListStatus.initial) HistoryListStatus historyStatus,
  }) = _HistoryListState;

  int get historyLength => historyEntity?.historyList.length ?? 0;
}
