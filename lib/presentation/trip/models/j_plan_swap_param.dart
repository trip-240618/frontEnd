import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/j_plan_entity.dart';

part 'j_plan_swap_param.freezed.dart';
part 'j_plan_swap_param.g.dart';

@freezed
abstract class JPlanSwapParam with _$JPlanSwapParam {
  const JPlanSwapParam._();

  const factory JPlanSwapParam({
    required int planId,
    required int dayAfterStart,
    required int orderByDate,
    required String startTime,
    required String title,
    String? memo,
    required bool locker,
  }) = _JPlanSwapParam;

  factory JPlanSwapParam.fromEntity(JPlanEntity entity) {
    return JPlanSwapParam(
      planId: entity.planId,
      dayAfterStart: entity.dayAfterStart,
      orderByDate: entity.orderByDate,
      startTime: entity.startTime,
      title: entity.title,
      memo: entity.memo,
      locker: entity.locker,
    );
  }

  factory JPlanSwapParam.fromJson(Map<String, dynamic> json) => _$JPlanSwapParamFromJson(json);
}
