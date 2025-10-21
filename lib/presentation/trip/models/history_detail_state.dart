import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/domain/entities/history_reply_entity.dart';

part 'history_detail_state.freezed.dart';

@freezed
abstract class HistoryDetailState with _$HistoryDetailState {
  const HistoryDetailState._();

  const factory HistoryDetailState({
    @Default({}) Map<int, HistoryEntity> historyDetailEntities,
    @Default([]) List<HistoryReplyEntity> replies,
  }) = _HistoryDetailState;

  int get historiesDetailLength => historyDetailEntities.length;
}
