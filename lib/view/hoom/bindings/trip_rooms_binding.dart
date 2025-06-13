import 'package:get/get.dart';
import 'package:tripStory/app/data/providers/file_client.dart';
import 'package:tripStory/app/data/providers/trip_client.dart';
import 'package:tripStory/app/data/repositories/file_repository.dart';
import 'package:tripStory/app/data/repositories/file_repository_impl.dart';
import 'package:tripStory/app/data/repositories/trip_repository.dart';
import 'package:tripStory/app/data/repositories/trip_repository_impl.dart';
import 'package:tripStory/view/hoom/controller/trip_rooms_create_controller.dart';

class TripRoomsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripRepository>(() => TripRepositoryImpl(Get.find<TripClient>()));
    Get.lazyPut<FileRepository>(() => FileRepositoryImpl(Get.find<FileClient>()));
    Get.lazyPut<TripRoomsCreateController>(
      () => TripRoomsCreateController(
        Get.find<TripRepository>(),
        Get.find<FileRepository>(),
      ),
    );
  }
}
