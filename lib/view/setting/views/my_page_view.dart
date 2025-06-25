import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/icon_button.dart';
import 'package:tripStory/common/button/profile_image_button.dart';
import 'package:tripStory/common/button/tile_list_button.dart';
import 'package:tripStory/common/image/cached_image.dart';
import 'package:tripStory/component/toast/toast.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/view/myPage/setting/setting_main_page.dart';
import 'package:tripStory/view/setting/controllers/my_page_controller.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({
    super.key,
  });

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final _myPageController = Get.find<MyPageController>();
  FToast? fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast?.init(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _myPageController.getVisitedCountry(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPageController>(
      builder: (controller) {
        Future.microtask(() {
          final state = controller.state;
          final showToast = state.showToast?.consume() ?? false;
          if (!context.mounted) return;

          if (showToast) {
            showCustomToast(context, fToast!, "현재 준비 중인 기능입니다.", false);
          }
        });
        return Scaffold(
          appBar: AppAppbar(
            text: "마이 페이지",
            backgroundColor: context.color.white,
            actionWidget: AppIconButton(
              onTap: () => Get.to(() => SettingMainPage()),
              assetPath: IconConstants.setting,
            ),
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 20,
                      top: 60,
                      bottom: 35,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileImageButton(
                          onPressed: () => controller.onProfilePressed(),
                          url: controller.user?.profileImg ?? "",
                          iconPath: IconConstants.pencil,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 11),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.user?.nickName ?? "",
                                style: context.style.headline3,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                controller.user?.memo ?? "",
                                style: context.style.label1Normal.copyWith(
                                  color: context.color.gray600,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "다녀온 여행지",
                          style: context.style.body1Reading,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              "국내 ${controller.state.domesticCount}",
                              style: context.style.heading1.copyWith(
                                color: context.color.blue,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              "해외 ${controller.state.abroadCount}",
                              style: context.style.heading1.copyWith(
                                color: context.color.red,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 31,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 200,
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: controller.state.visitedCountryCount,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 24,
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(2),
                                          child: CachedImage(
                                            imageUrl: controller.state.visitedCountryItems[index].imageUrl ?? "",
                                            width: 32,
                                            height: 24,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          "${controller.state.visitedCountryItems[index].country} (${controller.state.visitedCountryItems[index].visitCnt})",
                                          style: context.style.body1Normal.copyWith(
                                            color: context.color.gray800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 6,
                    color: context.color.neutral100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 28,
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      "앱 초대",
                      style: context.style.body1Reading.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TileListButton(
                    text: "초대 링크 보내기",
                    onTap: () => controller.onInvitedLinkPressed(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Divider(
                    thickness: 6,
                    color: context.color.neutral100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 28,
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      "이용 안내",
                      style: context.style.body1Reading.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TileListButton(
                    text: "공지사항",
                    onTap: () => controller.onNoticePressed(),
                  ),
                  TileListButton(
                    text: "FAQ",
                    onTap: () => controller.onFaqPressed(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
