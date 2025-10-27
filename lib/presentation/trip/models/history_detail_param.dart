import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';

part 'history_detail_param.freezed.dart';

@freezed
abstract class HistoryDetailParam with _$HistoryDetailParam {
  const HistoryDetailParam._();

  const factory HistoryDetailParam({
    @Default([]) List<int> historiesIds,
    required int selectedHistoryId,
  }) = _HistoryDetailParam;

  int get selectedIndex => historiesIds.indexOf(selectedHistoryId);
}
