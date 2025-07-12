import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_j_swap_request.freezed.dart';
part 'plan_j_swap_request.g.dart';

@freezed
abstract class PlanJSwapRequest with _$PlanJSwapRequest {
  const factory PlanJSwapRequest({
    required int dayAfterStart,
    required List<OrderDto> orderDtos,
  }) = _PlanJSwapRequest;

  factory PlanJSwapRequest.fromJson(Map<String, dynamic> json) => _$PlanJSwapRequestFromJson(json);
}

@freezed
abstract class OrderDto with _$OrderDto {
  const factory OrderDto({
    required int planId,
    required String startTime,
    required int orderByDate,
  }) = _OrderDto;

  factory OrderDto.fromJson(Map<String, dynamic> json) => _$OrderDtoFromJson(json);
}
