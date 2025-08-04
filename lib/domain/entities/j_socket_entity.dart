import 'package:tripStory/domain/entities/j_plan_entity.dart';

sealed class JSocketEntity {}

class PlanAdded extends JSocketEntity {
  final JPlanEntity plan;

  PlanAdded({
    required this.plan,
  });
}

class PlanDeleted extends JSocketEntity {
  final int dayAfterStart;
  final int planId;

  PlanDeleted({
    required this.dayAfterStart,
    required this.planId,
  });
}

class PlanModify extends JSocketEntity {
  final JPlanEntity plan;

  PlanModify({
    required this.plan,
  });
}

class PlanRegister extends JSocketEntity {
  final int day;
  final String editorUuid;
  final String nickname;

  PlanRegister({
    required this.day,
    required this.editorUuid,
    required this.nickname,
  });
}
