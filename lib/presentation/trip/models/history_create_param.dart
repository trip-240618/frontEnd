import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';

part 'history_create_param.freezed.dart';

@freezed
abstract class HistoryCreateParam with _$HistoryCreateParam {
  const HistoryCreateParam._();

  const factory HistoryCreateParam({
    @Default([]) List<AssetEntity> images,
    DateTime? photoDate,
  }) = _HistoryCreateParam;
}
