import 'package:get/get.dart';
import 'package:tripStory/presentation/login/controller/term_controller.dart';

class TermBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermController());
  }
}
