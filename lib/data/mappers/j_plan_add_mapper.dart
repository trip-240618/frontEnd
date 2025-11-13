import 'package:tripStory/data/models/response/plan_j_response.dart';
import 'package:tripStory/domain/entities/j_plan_entity.dart';
import 'package:tripStory/domain/entities/j_socket_entity.dart';

class JPlanAddMapper {
  static PlanAddedEntity toEntity(PlanResponse res) {
    return PlanAddedEntity(
      plan: JPlanEntity(
        planId: res.planId,
        dayAfterStart: res.dayAfterStart,
        orderByDate: res.orderByDate,
        startTime: res.startTime,
        title: res.title,
        memo: res.memo,
        place: res.place,
        latitude: res.latitude,
        longitude: res.longitude,
        locker: res.locker,
      ),
    );
  }
}
