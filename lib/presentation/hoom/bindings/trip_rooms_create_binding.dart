import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/create_trip_room_usecase.dart';
import 'package:tripStory/domain/usecases/first_enter_trip_room_usecase.dart';
import 'package:tripStory/presentation/hoom/controller/trip_rooms_create_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class TripRoomsCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateTripRoomUseCase(
          Get.find<TripRepository>(),
          Get.find<FileRepository>(),
        ));
    Get.lazyPut(() => FirstEnterTripRoomUsecase(
          Get.find<TripRepository>(),
        ));

    Get.lazyPut(
      () => TripRoomsCreateController(
        Get.find<CreateTripRoomUseCase>(),
        Get.find<FirstEnterTripRoomUsecase>(),
        Get.find<TripRoomService>(),
      ),
    );
  }
}
