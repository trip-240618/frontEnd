import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:tripStory/core/util/one_time_event.dart';
import 'package:tripStory/domain/entities/tag_entity.dart';

part 'history_create_state.freezed.dart';

@freezed
abstract class HistoryCreateState with _$HistoryCreateState {
  const HistoryCreateState._();

  const factory HistoryCreateState({
    @Default([]) List<HistoryItem> historyItems,
    OneTimeEvent<bool>? showMaxUploadDialog,
  }) = _HistoryCreateState;

  int get historyLength => historyItems.length;

  List<AssetEntity> get images => historyItems.map((historyItem) => historyItem.image).toList();
}

@freezed
abstract class HistoryItem with _$HistoryItem {
  const HistoryItem._();

  const factory HistoryItem({
    required AssetEntity image,
    @Default([]) List<TagEntity> tags,
    @Default("") String memo,
  }) = _HistoryItem;

  bool get isNotEmptyTags => tags.isNotEmpty;
}
