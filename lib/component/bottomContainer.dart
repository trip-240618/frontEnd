import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/util/font.dart';

import '../util/color.dart';

class BottomContainer extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  BottomContainer({Key? key, required this.onTap, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xffEEEEEE)
        ),
        child: Center(child: Text('${title}',style: f16Gray600w600)),
      ),
    );
  }
}