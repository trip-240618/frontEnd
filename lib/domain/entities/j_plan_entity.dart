import 'package:freezed_annotation/freezed_annotation.dart';

part 'j_plan_entity.freezed.dart';

@freezed
abstract class JPlanEntity with _$JPlanEntity {
  const factory JPlanEntity({
    required int planId,
    required int dayAfterStart,
    required int orderByDate,
    required String startTime,
    required String title,
    String? memo,
    String? place,
    double? latitude,
    double? longitude,
    required bool locker,
  }) = _JPlanEntity;
}
