import 'package:tripStory/data/models/response/plan_j_response.dart';
import 'package:tripStory/domain/entities/j_plan_entity.dart';

class JPlanSocketMapper {
  static JPlanEntity toEntity(PlanJResponse response) {
    return JPlanEntity(
      planId: response.planId,
      dayAfterStart: response.dayAfterStart,
      orderByDate: response.orderByDate,
      startTime: DateTime.parse(response.startTime),
      title: response.title,
      memo: response.memo,
      place: response.place,
      latitude: response.latitude,
      longitude: response.longitude,
      locker: response.locker,
    );
  }
}
