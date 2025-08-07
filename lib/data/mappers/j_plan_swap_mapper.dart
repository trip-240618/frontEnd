import 'package:tripStory/data/mappers/j_plan_mapper.dart';
import 'package:tripStory/data/models/request/plan_j_swap_request.dart';
import 'package:tripStory/data/models/response/plan_j_response.dart';
import 'package:tripStory/domain/entities/j_plan_swap_entity.dart';
import 'package:tripStory/domain/entities/j_socket_entity.dart';

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

  static PlanSwapEntity toEntity(PlanJResponse response) {
    return PlanSwapEntity(
      dayAfterStart: response.dayAfterStart,
      planList: response.planList.map(JPlanMapper.toEntity).toList(),
    );
  }
}
