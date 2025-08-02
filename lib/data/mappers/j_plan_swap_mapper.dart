import 'package:tripStory/data/models/request/plan_j_swap_request.dart';
import 'package:tripStory/domain/entities/j_plan_swap_entity.dart';

class JPlanSwapMapper {
  static PlanJSwapRequest toRequestModel(JPlanSwapEntity entity) {
    return PlanJSwapRequest(
      dayAfterStart: entity.dayAfterStart,
      orderDtos: entity.orderList.map((order) {
        return OrderDto(
          planId: order.planId,
          startTime: order.startTime,
          orderByDate: order.orderByDate,
        );
      }).toList(),
    );
  }
}
