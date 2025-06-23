import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/button/bottom_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class RegisterSuccessView extends StatefulWidget {
  const RegisterSuccessView({
    super.key,
  });

  @override
  State<RegisterSuccessView> createState() => _RegisterSuccessViewState();
}

class _RegisterSuccessViewState extends State<RegisterSuccessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 44,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: context.color.gray900,
                  shape: BoxShape.circle,
                ),
                child: SvgIcon(
                  assetPath: IconConstants.successCheck,
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              "회원가입을 완료했어요",
              style: context.style.title3,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 42,
        ),
        child: BottomButton(
          text: "다음",
          onTap: () => Get.offAllNamed(Routes.rooms),
        ),
      ),
    );
  }
}
