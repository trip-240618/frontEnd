import 'package:tripStory/data/models/request/plan_j_modify_request.dart';
import 'package:tripStory/data/models/response/plan_j_response.dart';
import 'package:tripStory/domain/entities/j_plan_entity.dart';

class JPlanMapper {
  static JPlanEntity toEntity(PlanResponse response) {
    return JPlanEntity(
      planId: response.planId,
      dayAfterStart: response.dayAfterStart,
      orderByDate: response.orderByDate,
      startTime: response.startTime,
      title: response.title,
      memo: response.memo,
      place: response.place,
      latitude: response.latitude,
      longitude: response.longitude,
      locker: response.locker,
    );
  }

  static PlanJModifyRequest toModifyRequest(JPlanEntity entity) {
    return PlanJModifyRequest(
      planId: entity.planId,
      dayAfterStart: entity.dayAfterStart,
      orderByDate: entity.orderByDate,
      startTime: entity.startTime,
      title: entity.title,
      memo: entity.memo ?? "",
      place: entity.place ?? "",
      latitude: entity.latitude,
      longitude: entity.longitude ?? 0.0,
      locker: entity.locker,
    );
  }
}
