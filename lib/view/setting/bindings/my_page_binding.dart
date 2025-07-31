import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/country_repository.dart';
import 'package:tripStory/domain/usecases/fetch_visited_country_usecase.dart';
import 'package:tripStory/view/global/login_user_service.dart';
import 'package:tripStory/view/setting/controllers/my_page_controller.dart';

class MyPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchVisitedCountryUsecase(Get.find<CountryRepository>()));
    Get.lazyPut<MyPageController>(
      () => MyPageController(
        Get.find<LoginUserService>(),
        Get.find<FetchVisitedCountryUsecase>(),
      ),
    );
  }
}
