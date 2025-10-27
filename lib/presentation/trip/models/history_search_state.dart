import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/core/enum/history_search_type.dart';
import 'package:tripStory/domain/entities/tag_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';

part 'history_search_state.freezed.dart';

@freezed
abstract class HistorySearchState with _$HistorySearchState {
  const HistorySearchState._();

  const factory HistorySearchState({
    @Default(HistorySearchType.tag) HistorySearchType historySearchType,
    @Default(false) bool searchMode,
    @Default([]) List<TagEntity> tags,
    @Default([]) List<TripMemberEntity> members,
  }) = _HistorySearchState;

  bool get isSearchEmpty => tags.isEmpty && members.isEmpty;
}
