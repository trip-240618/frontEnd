import 'package:tripStory/domain/entities/j_plan_entity.dart';

class JPlanEditParams {
  final DateTime selectedDate;
  final JPlanEntity? jPlan;

  const JPlanEditParams({
    required this.selectedDate,
    this.jPlan,
  });

  bool get isEdit => jPlan != null;
}
