import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class EmptyScreen extends StatelessWidget {
  final String content;

  const EmptyScreen({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            content,
            style: context.style.heading1.copyWith(color: context.color.gray400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

Widget DefaultImageScreen(BuildContext context) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: context.color.gray100),
    width: 66,
    height: 66,
    child: SvgPicture.asset(
      'assets/icon/default.svg',
      fit: BoxFit.none,
    ),
  );
}

Widget DefaultProfileScreen(BuildContext context) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: context.color.gray200),
    child: SvgPicture.asset(
      'assets/icon/defaultIcon.svg',
      fit: BoxFit.none,
    ),
  );
}

Widget SettingDefaultProfileScreen(BuildContext context) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: context.color.gray200),
    width: 80,
    height: 80,
    child: Align(
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/icon/defaultIcon.svg',
        width: 24, // 원하는 아이콘 크기로 설정
        height: 24,
        fit: BoxFit.contain,
      ),
    ),
  );
}
