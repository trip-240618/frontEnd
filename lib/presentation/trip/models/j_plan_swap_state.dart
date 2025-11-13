import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/presentation/trip/models/j_plan_swap_param.dart';

part 'j_plan_swap_state.freezed.dart';

@freezed
abstract class JPlanSwapState with _$JPlanSwapState {
  const JPlanSwapState._();

  const factory JPlanSwapState({
    @Default([]) List<JPlanSwapParam> plans,
    JPlanSwapParam? selectedPlan,
  }) = _JPlanSwapState;

  int get planLength => plans.length;
}
