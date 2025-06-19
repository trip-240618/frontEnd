import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/create_trip_room_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_presigned_url_usecase.dart';
import 'package:tripStory/view/hoom/controller/trip_rooms_create_controller.dart';

class TripRoomsCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchPresignedUrlUsecase(Get.find<FileRepository>()));
    Get.lazyPut(() => CreateTripRoomUseCase(Get.find<TripRepository>()));

    Get.lazyPut(
      () => TripRoomsCreateController(
        Get.find<CreateTripRoomUseCase>(),
        Get.find<FetchPresignedUrlUsecase>(),
      ),
    );
  }
}
