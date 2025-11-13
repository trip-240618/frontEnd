import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class EditJPlanParams {
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
  final bool locker;

  const EditJPlanParams({
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
    required this.locker,
  });
}

class EditJPlanUsecase implements UseCase<void, EditJPlanParams> {
  final TripRepository repository;

  EditJPlanUsecase(this.repository);

  @override
  ResultFuture<void> call(EditJPlanParams params) async {
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
      locker: params.locker,
    );
  }
}
