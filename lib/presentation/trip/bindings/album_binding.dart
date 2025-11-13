import 'package:get/get.dart';
import 'package:tripStory/presentation/trip/controllers/album_controller.dart';

class AlbumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlbumController>(
      () => AlbumController(),
    );
  }
}
