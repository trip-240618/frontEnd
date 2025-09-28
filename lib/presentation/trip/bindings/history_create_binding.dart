import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/create_histories_upload_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/history_create_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class HistoryCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateHistoriesUploadUsecase(
          Get.find<TripRepository>(),
          Get.find<FileRepository>(),
        ));
    Get.lazyPut<HistoryCreateController>(
      () => HistoryCreateController(
        Get.find<TripRoomService>(),
        Get.find<CreateHistoriesUploadUsecase>(),
      ),
    );
  }
}
