import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/tile_list_button.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/url_launch.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/view/login/loginPage.dart';
import 'package:tripStory/view/myPage/setting/cancel/setting_delete_page.dart';
import 'package:tripStory/view/myPage/setting/setting_alim_page.dart';
import 'package:tripStory/view/setting/controllers/my_page_setting_controller.dart';

class MyPageSettingView extends StatefulWidget {
  const MyPageSettingView({
    super.key,
  });

  @override
  State<MyPageSettingView> createState() => _MyPageSettingViewState();
}

class _MyPageSettingViewState extends State<MyPageSettingView> {
  final us = Get.put(UserState());
  String locationStatusText = '확인 중...';
  String versionText = '0.0.0';

  @override
  void initState() {
    super.initState();
    _initializeSettings();
  }

  Future<void> _initializeSettings() async {
    try {
      /// 앱 버전 정보 가져오기
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String fetchedVersion = packageInfo.version;

      /// 위치 권한 상태 가져오기
      String fetchedLocationStatus = await getLocationPermissionStatus();

      setState(() {
        versionText = fetchedVersion;
        locationStatusText = fetchedLocationStatus;
      });
    } catch (e) {
      print('초기화 중 에러 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPageSettingController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppAppbar(
            text: "설정",
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SettingNotificationSection(
                  onSettingPressed: () => Get.to(() => SettingAlimPage()),
                ),
                Divider(
                  thickness: 6,
                  color: lightGray1,
                ),
                const SizedBox(
                  height: 33,
                ),
                _SettingUserSection(
                  onDeletedPressed: () => Get.to(() => SettingDeletePage()),
                  onLogOutPressed: () => showConfirmCancelTapDialog(context, '로그아웃을 하시겠어요?', '확인', null, () {
                    Get.offAll(() => LoginPage());
                    us.logOut();
                  }),
                ),
                Divider(
                  thickness: 6,
                  color: lightGray1,
                ),
                const SizedBox(
                  height: 33,
                ),
                _SettingServiceSection(
                  locationServiceText: controller.state.locationText,
                ),
                Divider(
                  thickness: 6,
                  color: lightGray1,
                ),
                const SizedBox(
                  height: 33,
                ),
                _SettingInfoSection(
                  versionText: controller.state.appVersionText,
                  onPrivatePressed: () => urlLaunch("https://trip-story.site/policy/privacy"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SettingNotificationSection extends StatelessWidget {
  final VoidCallback onSettingPressed;

  const _SettingNotificationSection({
    required this.onSettingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 28,
            left: 20,
            right: 20,
          ),
          child: Text(
            "알림",
            style: context.style.body1Reading.copyWith(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TileListButton(
          text: "알림 설정",
          onTap: () => Get.to(() => SettingAlimPage()),
        ),
      ],
    );
  }
}

class _SettingUserSection extends StatelessWidget {
  final VoidCallback onDeletedPressed;
  final VoidCallback onLogOutPressed;

  const _SettingUserSection({
    required this.onDeletedPressed,
    required this.onLogOutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Text(
            "계정 관리",
            style: context.style.body1Reading.copyWith(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TileListButton(
          text: "회원 탈퇴",
          onTap: onLogOutPressed,
        ),
        TileListButton(
          text: "로그아웃",
          onTap: onDeletedPressed,
        ),
      ],
    );
  }
}

class _SettingServiceSection extends StatelessWidget {
  final String locationServiceText;

  const _SettingServiceSection({
    required this.locationServiceText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Text(
            "서비스 설정",
            style: context.style.body1Reading.copyWith(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TileListButton(
          text: "위치 서비스",
          trailing: Text(
            locationServiceText,
            style: context.style.label1Normal.copyWith(
              color: context.color.blue,
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingInfoSection extends StatelessWidget {
  final String versionText;
  final VoidCallback onPrivatePressed;

  const _SettingInfoSection({
    required this.versionText,
    required this.onPrivatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Text(
            "정보",
            style: context.style.body1Reading.copyWith(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TileListButton(
          text: "앱 버전",
          trailing: Text(
            versionText,
            style: context.style.caption1,
          ),
        ),
        TileListButton(
          text: "약관 및 정책",
          onTap: onPrivatePressed,
        ),
      ],
    );
  }
}
