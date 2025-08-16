import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/url_launch.dart';
import 'package:tripStory/core/constants/app_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/appbar/app_appbar.dart';
import 'package:tripStory/presentation/common/button/tile/tile_list_button.dart';
import 'package:tripStory/presentation/common/dialog/common_dialog.dart';
import 'package:tripStory/presentation/setting/controllers/my_page_setting_controller.dart';

class MyPageSettingView extends StatelessWidget {
  const MyPageSettingView({
    super.key,
  });

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
                  onSettingPressed: () => controller.onAlimSettingPressed(),
                ),
                Divider(
                  thickness: 6,
                  color: context.color.gray200,
                ),
                const SizedBox(
                  height: 33,
                ),
                _SettingUserSection(
                  onDeletedPressed: () => controller.onUserDeletePressed(),
                  onLogOutPressed: () => showLogOutDialog(
                    () => controller.onLogOutPressed(),
                  ),
                ),
                Divider(
                  thickness: 6,
                  color: context.color.gray200,
                ),
                const SizedBox(
                  height: 33,
                ),
                _SettingServiceSection(
                  locationServiceText: controller.state.locationText,
                ),
                Divider(
                  thickness: 6,
                  color: context.color.gray200,
                ),
                const SizedBox(
                  height: 33,
                ),
                _SettingInfoSection(
                  versionText: controller.state.appVersionText,
                  onPrivatePressed: () => urlLaunch(AppConstants.privacyPolicy),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showLogOutDialog(
    VoidCallback onConfirmPressed,
  ) {
    CommonDialog.show(
      title: "로그아웃을 하시겠어요?",
      confirmText: "확인",
      onConfirm: onConfirmPressed,
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
          onTap: onSettingPressed,
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
          onTap: onDeletedPressed,
        ),
        TileListButton(
          text: "로그아웃",
          onTap: onLogOutPressed,
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
