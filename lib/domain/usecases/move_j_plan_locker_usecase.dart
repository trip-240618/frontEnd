import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/mappers/j_plan_mapper.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/j_plan_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class MoveJPlanLockerParams {
  final int tripId;
  final int planId;
  final int dayAfterStart;
  final int? orderByDate;
  final String startTime;
  final String title;
  final String? place;
  final String? memo;
  final double? latitude;
  final double? longitude;

  const MoveJPlanLockerParams({
    required this.tripId,
    required this.planId,
    required this.dayAfterStart,
    this.orderByDate,
    required this.startTime,
    required this.title,
    this.place,
    this.memo,
    this.latitude,
    this.longitude,
  });
}

class MoveJPlanLockerUsecase implements UseCase<void, MoveJPlanLockerParams> {
  final TripRepository repository;

  MoveJPlanLockerUsecase(this.repository);

  @override
  ResultFuture<void> call(MoveJPlanLockerParams params) async {
    return repository.putModifyJPlan(
      tripId: params.tripId,
      planId: params.planId,
      dayAfterStart: params.dayAfterStart,
      orderByDate: params.orderByDate,
      startTime: params.startTime,
      title: params.title,
      place: params.place,
      memo: params.memo,
      latitude: params.latitude,
      longitude: params.longitude,
      locker: true,
    );
  }
}
