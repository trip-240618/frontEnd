import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/notice_repository.dart';
import 'package:tripStory/domain/usecases/fetch_notices_usecase.dart';
import 'package:tripStory/view/setting/controllers/notices_list_controller.dart';

class NoticesListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchNoticesUsecase(Get.find<NoticeRepository>()));
    Get.lazyPut<NoticesListController>(
      () => NoticesListController(
        Get.find<FetchNoticesUsecase>(),
      ),
    );
  }
}
