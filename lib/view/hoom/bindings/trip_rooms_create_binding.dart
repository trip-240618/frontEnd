import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/usecases/fetch_presigned_url_usecase.dart';

class TripRoomsCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchPresignedUrlUsecase(Get.find<FileRepository>()));
  }
}
