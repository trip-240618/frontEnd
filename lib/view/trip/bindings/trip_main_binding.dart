import 'package:get/get.dart';
import 'package:tripStory/view/trip/controllers/trip_main_controller.dart';

class TripMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TripMainController());
  }
}
