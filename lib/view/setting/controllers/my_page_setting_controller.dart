import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tripStory/core/permission/permission_type.dart';
import 'package:tripStory/core/permission/permisson.dart';
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/view/setting/models/my_page_setting_state.dart';

class MyPageSettingController extends GetxController {
  MyPageSettingState _myPageSettingState = MyPageSettingState();

  MyPageSettingState get state => _myPageSettingState;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await Future.wait([
      _getVersionInfo(),
      _getLocationInfo(),
    ]);
  }

  Future<void> _getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _myPageSettingState = state.copyWith(
      appVersionText: packageInfo.version,
    );
    update();
  }

  Future<void> _getLocationInfo() async {
    final status = await getPermissionStatus(PermissionType.location);

    _myPageSettingState = state.copyWith(
      locationPermissionState: status,
    );
    update();
  }

  void onAlimSettingPressed() => Get.toNamed(Routes.alimSetting);
}
