import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

SnackBar buildCustomSnackBar(String message) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    width: Get.width*0.8,
    duration: const Duration(seconds: 2),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: SvgPicture.asset(
            'assets/icon/logo.svg',
            width: 24,
            height: 24,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ],
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  );
}
