import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/util/font.dart';

class BottomContainer extends StatelessWidget {
  final VoidCallback onTap;
  BottomContainer({Key? key, required this.onTap}) : super(key: key);

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
        child: Center(child: Text('다음으로',style: f16Gray600w600)),
      ),
    );
  }
}