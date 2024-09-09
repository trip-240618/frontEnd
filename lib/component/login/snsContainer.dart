import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../util/font.dart';

class KakaoContainer extends StatelessWidget {
  final VoidCallback onTap;
  KakaoContainer({Key? key, required this.onTap}) : super(key: key);

  final animationDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 60,
        decoration: BoxDecoration(
            color: Color(0xffFEE500),
            borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/sns/kakao.svg'),
            const SizedBox(width: 8),
            Text('카카오로 시작하기',style: f16Gray900w600,),
          ],
        ),
      ),
    );
  }
}

class GoogleContainer extends StatelessWidget {
  final VoidCallback onTap;
  GoogleContainer({Key? key, required this.onTap}) : super(key: key);

  final animationDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: Get.width,
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xffE0E0E0)),
              borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/sns/google.svg'),
              const SizedBox(width: 8),
              Text('구글로 시작하기',style: f16Gray900w600,),
            ],
          )
      ),
    );
  }
}

class AppleContainer extends StatelessWidget {
  final VoidCallback onTap;
  AppleContainer({Key? key, required this.onTap}) : super(key: key);

  final animationDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  Container(
        width: Get.width,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/sns/apple.svg'),
            const SizedBox(width: 8),
            Text('Apple로 시작하기',style: f16Whitew600,),
          ],
        ),
      )
    );
  }
}