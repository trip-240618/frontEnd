import 'package:tripStory/domain/entities/j_plan_entity.dart';

sealed class JSocketEntity {}

class PlanAdded extends JSocketEntity {
  final JPlanEntity plan;

  PlanAdded(this.plan);
}
