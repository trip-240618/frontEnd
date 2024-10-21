import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../util/font.dart';

class SettingArrowRow extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SettingArrowRow({
    required this.title,
    required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 44,
        child: Row(
          children: [
            Text(title, style: f14Gray700w500),
            Spacer(),
            SizedBox(
              child: SvgPicture.asset(
                'assets/icon/rightArrow.svg',
                fit: BoxFit.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}