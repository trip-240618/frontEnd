import 'package:tripStory/data/models/response/j_plan_deleted_response.dart';
import 'package:tripStory/domain/entities/j_socket_entity.dart';

class JPlanDeleteMapper {
  static PlanDeletedEntity toEntity(JPlanDeletedResponse res) {
    return PlanDeletedEntity(
      dayAfterStart: res.dayAfterStart,
      planId: res.planId,
    );
  }
}
