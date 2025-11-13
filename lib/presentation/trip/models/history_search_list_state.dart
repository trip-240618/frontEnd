import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';

part 'history_search_list_state.freezed.dart';

enum HistorySearchListStatus {
  initial,
  empty,
  success,
  loading,
}

@freezed
abstract class HistorySearchListState with _$HistorySearchListState {
  const HistorySearchListState._();

  const factory HistorySearchListState({
    @Default(HistorySearchListStatus.initial) HistorySearchListStatus historySearchListStatus,
    @Default([]) List<HistoryEntity>? histories,
  }) = _HistorySearchListState;
}
