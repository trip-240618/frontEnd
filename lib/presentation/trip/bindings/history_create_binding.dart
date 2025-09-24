import 'package:get/get.dart';
import 'package:tripStory/presentation/trip/controllers/history_create_controller.dart';

class HistoryCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryCreateController>(
      () => HistoryCreateController(),
    );
  }
}
