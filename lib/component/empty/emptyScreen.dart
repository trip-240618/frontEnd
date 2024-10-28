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