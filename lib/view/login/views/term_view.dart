import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/button/check_tile_button.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/component/container/circle_badge.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/url_launch.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/login/controller/term_controller.dart';
import 'package:tripStory/view/login/register/profile.dart';

class TermView extends StatefulWidget {
  const TermView({super.key});

  @override
  State<TermView> createState() => _TermViewState();
}

class _TermViewState extends State<TermView> {
  bool allCheck = true;

  /// 전체 동의 체크
  bool policyCheck = false;

  /// 이용약관 체크
  bool privatePolicyCheck = false;

  /// 개인정보 처리방침 체크
  bool locationCheck = false;

  /// 위치 정보 서비스 이용약관
  bool inforCheck = false;

  /// 제3자 정보제공 동의
  bool maratCheck = false;

  /// 마케팅 정보 수신 동의
  bool isChecked = false;

  /// 약관동의 체크
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TermController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 42,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleBadge(
                    text: "1",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleBadge(
                    text: "2",
                    enabled: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "가입을 완료하려면\n서비스 약관 동의가 필요해요",
                style: f22gray900w700,
              ),
              const SizedBox(height: 35),
              CheckTileButton(
                text: "서비스 이용약관 전체 동의",
                isActive: controller.state.isAllTerms,
                tileColor: gray50,
                borderColor: controller.state.isAllTerms ? gray900 : null,
                onTap: () => controller.onAllTermPressed(),
                onTrailingTap: () async => await urlLaunch("https://trip-story.site/policy/service"),
              ),
              const SizedBox(height: 28),
              CheckTileButton(
                text: "(필수) 서비스 이용약관",
                isActive: controller.state.isServiceTerm,
                onTap: () => controller.onServiceTermPressed(),
                onTrailingTap: () async => await urlLaunch("https://trip-story.site/policy/service"),
              ),
              CheckTileButton(
                text: "(필수) 개인정보 수집 및 이용약관",
                isActive: controller.state.isPrivateTerm,
                onTap: () => controller.onPrivateTermPressed(),
                onTrailingTap: () async => await urlLaunch("https://trip-story.site/policy/privacy"),
              ),
              CheckTileButton(
                text: "(필수) 위치정보 서비스 이용약관",
                isActive: controller.state.isLocationTerm,
                onTap: () => controller.onLocationTermPressed(),
                onTrailingTap: () async => await urlLaunch("https://trip-story.site/policy/location"),
              ),
              CheckTileButton(
                text: "(필수) 제3자 정보제공 동의",
                isActive: controller.state.isThreeTerm,
                onTap: () => controller.onThreeTermPressed(),
                onTrailingTap: () async => await urlLaunch("https://trip-story.site/policy/offerl"),
              ),
              CheckTileButton(
                text: "(선택) 마케팅 정보 수신 동의",
                isActive: controller.state.isMarketingTerm,
                onTap: () => controller.onMarketTermPressed(),
                onTrailingTap: () async => await urlLaunch("https://trip-story.site/policy/marketing"),
              ),
              Spacer(),
              BottomContainer(
                onTap: () async {
                  if (isChecked) {
                    Get.to(() => ProfilePage(
                          marketing: maratCheck,
                        ));
                  } else {
                    showOnlyConfirmTapDialog(context, '약관에 동의해주세요', () {
                      Get.back();
                    });
                  }
                },
                title: '다음',
                isBlack: isChecked ? true : false,
              )
            ],
          ),
        ),
      );
    });
  }

  /// 권한
  void updateAllCheckStatus() {
    if (policyCheck && privatePolicyCheck && locationCheck && inforCheck) {
      isChecked = true;
    } else {
      isChecked = false;
    }
  }
}
