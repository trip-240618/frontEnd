import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/core/util/helper/route_helper.dart';
import 'package:tripStory/domain/entities/flight_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/create_flight_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class FlightCreateController extends GetxController {
  final TripRoomService _tripRoomService;
  final CreateFlightUsecase _createFlightUsecase;

  FlightCreateController(
    this._tripRoomService,
    this._createFlightUsecase,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  Future<void> onSavePressed(FlightEntity flightEntity) async {
    if (tripRoomInfo?.id == null) return;

    final param = Tuple2(tripRoomInfo?.id ?? 0, flightEntity);
    final result = await _createFlightUsecase.call(param);

    result.fold((error) {}, (flight) {
      RouteHelper.goBackToWithResult(Routes.searchFlight, flightEntity);
    });
  }
}
