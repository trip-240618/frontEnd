import 'package:tripStory/data/models/response/j_plan_deleted_response.dart';
import 'package:tripStory/domain/entities/j_socket_entity.dart';

class JPlanDeleteMapper {
  static PlanDeleted toEntity(JPlanDeletedResponse res) {
    return PlanDeleted(
      dayAfterStart: res.dayAfterStart,
      planId: res.planId,
    );
  }
}
