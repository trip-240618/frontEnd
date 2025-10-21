import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/fetch_history_detail_usecase.dart';
import 'package:tripStory/presentation/global/login_user_service.dart';
import 'package:tripStory/presentation/trip/controllers/history_detail_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class HistoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchHistoryDetailUsecase(
          Get.find<TripRepository>(),
        ));
    Get.lazyPut<HistoryDetailController>(
      () => HistoryDetailController(
        Get.find<TripRoomService>(),
        Get.find<FetchHistoryDetailUsecase>(),
        Get.find<LoginUserService>(),
      ),
    );
  }
}
