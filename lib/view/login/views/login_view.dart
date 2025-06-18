import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/button/round_button.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/login/controller/login_controller.dart';

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
              style: f22gray900w700,
            ),
            Spacer(),
            Center(
              child: Text(
                "트립스토리는 간편 로그인을 지원해요",
                style: f14gray600w500,
              ),
            ),
            const SizedBox(height: 18),
            RoundedBoxButton(
              onTap: () => controller.onKakaoPressed(),
              icon: SvgPicture.asset("assets/sns/kakao.svg"),
              text: "카카오로 시작하기",
              textStyle: f16sns400w700,
              backgroundColor: Color(0xffFEE500),
              borderRadius: 12,
              width: Get.width,
              height: 60,
            ),
            const SizedBox(height: 18),
            RoundedBoxButton(
              onTap: () => controller.onGooglePressed(),
              icon: SvgPicture.asset("assets/sns/google.svg"),
              text: "구글로 시작하기",
              textStyle: f16sns400w700,
              borderRadius: 12,
              borderColor: Color(0xffE0E0E0),
              width: Get.width,
              height: 60,
            ),
            if (!Platform.isAndroid) ...[
              const SizedBox(height: 18),
              RoundedBoxButton(
                onTap: () {},
                icon: SvgPicture.asset("assets/sns/apple.svg"),
                text: "Apple로 시작하기",
                textStyle: f16Whitew700,
                backgroundColor: Colors.black,
                borderRadius: 12,
                width: Get.width,
                height: 60,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
