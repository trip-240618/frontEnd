import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/button/base/base_tile_button.dart';
import 'package:tripStory/common/button/bottom_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/component/container/circle_badge.dart';
import 'package:tripStory/component/url_launch.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/login/controller/term_controller.dart';

class TermView extends StatelessWidget {
  const TermView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TermController>(
      builder: (controller) {
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
                      backgroundColor: gray900,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CircleBadge(
                      text: "2",
                      backgroundColor: gray200,
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
                BottomButton(
                  text: "다음",
                  enabled: controller.state.isAllTerms,
                  onTap: () => controller.onConfirmPressed(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CheckTileButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final Color? tileColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final VoidCallback? onTrailingTap;

  const CheckTileButton({
    super.key,
    required this.text,
    required this.isActive,
    this.tileColor,
    this.onTap,
    this.onTrailingTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTileButton(
      text: text,
      textStyle: isActive ? f15gray900w600 : f15gray800w500,
      onTap: onTap,
      tileColor: tileColor,
      borderColor: borderColor,
      leading: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF212121) : Colors.white,
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
          borderRadius: BorderRadius.circular(2),
        ),
        child: isActive
            ? SvgIcon(
                assetPath: IconConstants.smallCheck,
              )
            : null,
      ),
      trailing: GestureDetector(
        onTap: onTrailingTap,
        child: SvgIcon(
          assetPath: IconConstants.arrow,
        ),
      ),
    );
  }
}
