import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/flight_repository.dart';
import 'package:tripStory/domain/usecases/create_flight_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/flight_create_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class FlightCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateFlightUsecase(Get.find<FlightRepository>()));
    Get.lazyPut<FlightCreateController>(
      () => FlightCreateController(
        Get.find<TripRoomService>(),
        Get.find<CreateFlightUsecase>(),
      ),
    );
  }
}
