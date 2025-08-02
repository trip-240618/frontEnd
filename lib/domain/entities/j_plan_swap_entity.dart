import 'package:equatable/equatable.dart';

class JPlanSwapEntity extends Equatable {
  final int dayAfterStart;
  final List<JPlanSwapOrderEntity> orderList;

  const JPlanSwapEntity({
    required this.dayAfterStart,
    required this.orderList,
  });

  @override
  List<Object> get props => [dayAfterStart, orderList];
}

class JPlanSwapOrderEntity extends Equatable {
  final int planId;
  final String startTime;
  final int orderByDate;

  const JPlanSwapOrderEntity({
    required this.planId,
    required this.startTime,
    required this.orderByDate,
  });

  @override
  List<Object> get props => [planId, startTime, orderByDate];
}
