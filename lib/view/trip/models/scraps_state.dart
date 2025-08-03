import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/scrap_entity.dart';

part 'scraps_state.freezed.dart';

enum ScrapsStatus { initial, loading, success, empty, failure }

@freezed
abstract class ScrapsState with _$ScrapsState {
  const ScrapsState._();

  const factory ScrapsState({
    @Default(ScrapsStatus.initial) ScrapsStatus status,
    @Default([]) List<ScrapEntity> scraps,
  }) = _ScrapsState;

  bool get isEmpty => scraps.isEmpty;

  int get length => scraps.length;
}
