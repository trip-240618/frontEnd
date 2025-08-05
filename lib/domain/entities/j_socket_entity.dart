import 'package:tripStory/domain/entities/j_plan_entity.dart';

sealed class JSocketEntity {}

class PlanAddedEntity extends JSocketEntity {
  final JPlanEntity plan;

  PlanAddedEntity({
    required this.plan,
  });
}

class PlanDeletedEntity extends JSocketEntity {
  final int dayAfterStart;
  final int planId;

  PlanDeletedEntity({
    required this.dayAfterStart,
    required this.planId,
  });
}

class PlanModifyEntity extends JSocketEntity {
  final JPlanEntity plan;

  PlanModifyEntity({
    required this.plan,
  });
}

class PlanRegisterEntity extends JSocketEntity {
  final int day;
  final String editorUuid;
  final String nickname;

  PlanRegisterEntity({
    required this.day,
    required this.editorUuid,
    required this.nickname,
  });
}

class PlanWaitEntity extends JSocketEntity {
  final int day;
  final String editorUuid;
  final String nickname;

  PlanWaitEntity({
    required this.day,
    required this.editorUuid,
    required this.nickname,
  });
}

class PlanSwapEntity extends JSocketEntity {
  final int dayAfterStart;
  final List<JPlanEntity> planList;

  PlanSwapEntity({
    required this.dayAfterStart,
    required this.planList,
  });
}
