import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../util/color.dart';
import '../../util/font.dart';

Widget EmptyScreen(BuildContext context) {
  return Container(
    width: Get.width,
    height: Get.height*0.6,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('새 여행 일정을',style: f22gray400w700,),
        Text('트립스토리에 등록해 보세요',style: f22gray400w700,),
      ],
    ),
  );
}
Widget DefaultImageScreen(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: gray100
    ),
    width: 66,
    height: 66,
    child: SvgPicture.asset('assets/icon/default.svg',fit: BoxFit.none,),
  );
}
Widget DefaultProfileScreen(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: gray200
    ),
    child: SvgPicture.asset('assets/icon/defaultIcon.svg',fit: BoxFit.none,),
  );
}
Widget SettingDefaultProfileScreen(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: gray200
    ),
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