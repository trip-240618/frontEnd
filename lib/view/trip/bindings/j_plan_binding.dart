import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/flight_repository.dart';
import 'package:tripStory/domain/repositories/j_socket_repository.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/delete_flight_usecase.dart';
import 'package:tripStory/domain/usecases/delete_j_plan_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_flight_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_j_plan_usecase.dart';
import 'package:tripStory/domain/usecases/j_plan_connect_socket_usecase.dart';
import 'package:tripStory/domain/usecases/j_plan_disconnect_socket_usecase.dart';
import 'package:tripStory/domain/usecases/j_plan_listen_socket_usecase.dart';
import 'package:tripStory/domain/usecases/j_plan_swap_register_usecase.dart';
import 'package:tripStory/domain/usecases/move_j_plan_locker_usecase.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/j_plan_controller.dart';

class JPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchJPlanUsecase(Get.find<TripRepository>()));
    Get.lazyPut(() => DeleteJPlanUsecase(Get.find<TripRepository>()));
    Get.lazyPut(() => MoveJPlanLockerUsecase(Get.find<TripRepository>()));
    Get.lazyPut(() => JPlanSwapRegisterUsecase(Get.find<TripRepository>()));
    Get.lazyPut(() => JPlanConnectSocketUsecase(Get.find<JSocketRepository>()));
    Get.lazyPut(() => JPlanListenSocketUsecase(Get.find<JSocketRepository>()));
    Get.lazyPut(() => JPlanDisconnectSocketUsecase(Get.find<JSocketRepository>()));
    Get.lazyPut(() => FetchFlightUsecase(Get.find<FlightRepository>()));
    Get.lazyPut(() => DeleteFlightUsecase(Get.find<FlightRepository>()));

    Get.lazyPut<JPlanController>(
      () => JPlanController(
        Get.find<TripRoomService>(),
        Get.find<FetchJPlanUsecase>(),
        Get.find<DeleteJPlanUsecase>(),
        Get.find<MoveJPlanLockerUsecase>(),
        Get.find<JPlanSwapRegisterUsecase>(),
        Get.find<JPlanConnectSocketUsecase>(),
        Get.find<JPlanListenSocketUsecase>(),
        Get.find<JPlanDisconnectSocketUsecase>(),
        Get.find<FetchFlightUsecase>(),
        Get.find<DeleteFlightUsecase>(),
      ),
    );
  }
}
