import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/flight_repository.dart';
import 'package:tripStory/domain/usecases/fetch_flight_result_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/flight_search_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class FlightSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchFlightResultUsecase(Get.find<FlightRepository>()));

    Get.lazyPut<FlightSearchController>(
      () => FlightSearchController(
        Get.find<TripRoomService>(),
        Get.find<FetchFlightResultUsecase>(),
      ),
    );
  }
}
