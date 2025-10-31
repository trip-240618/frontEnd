import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/button/base/base_button.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';
import 'package:tripStory/presentation/login/controller/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 107,
          bottom: 50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "이제부터\n트립스토리와\n여행을 간단하게 기록해 보세요",
              style: context.style.heading1,
            ),
            Spacer(),
            Center(
              child: Text(
                "트립스토리는 간편 로그인을 지원해요",
                style: context.style.label1Reading.copyWith(
                  color: context.color.gray600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SnsButton(
              label: "카카오로 시작하기",
              labelColor: Color(0xff381E21),
              icon: IconConstants.kakao2Icon,
              onPressed: () => controller.onKakaoPressed(),
              backgroundColor: Color(0xffFEE500),
            ),
            const SizedBox(height: 12),
            _SnsButton(
              label: "Google로 시작하기",
              labelColor: context.color.gray800,
              backgroundColor: context.color.white,
              borderColor: context.color.gray300,
              icon: IconConstants.googleIcon,
              onPressed: () => controller.onGooglePressed(),
            ),
            if (!Platform.isAndroid) ...[
              const SizedBox(height: 12),
              _SnsButton(
                label: "Apple로 시작하기",
                labelColor: context.color.white,
                backgroundColor: context.color.black,
                borderColor: context.color.gray300,
                icon: IconConstants.appleIcon,
                onPressed: () => controller.onApplePressed(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SnsButton extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color backgroundColor;
  final Color? borderColor;
  final String icon;
  final VoidCallback onPressed;

  const _SnsButton({
    required this.label,
    required this.labelColor,
    required this.backgroundColor,
    this.borderColor,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 58,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: borderColor != null ? Border.all(width: 1.5, color: borderColor ?? context.color.white) : null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: BaseButton(
        onTap: onPressed,
        borderRadius: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(assetPath: icon),
            const SizedBox(
              width: 12,
            ),
            Text(
              label,
              style: context.style.body1Normal.copyWith(
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
