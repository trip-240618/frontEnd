
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../util/color.dart';
import '../util/font.dart';

/// icon TextFromField
class TextIconFormFields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String icon;

  const TextIconFormFields(
      {Key? key,
        required this.controller,
        required this.hintText,
        required this.icon,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: Get.width,
      // height: 52,
      // decoration: BoxDecoration(
      //   color: Color(0xffF5F6F7),
      //   borderRadius: BorderRadius.circular(64.0),
      // ),
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: f16gray800w600,
        decoration: InputDecoration(
            isDense: true,
            contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray200),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray200), // 포커스된 상태에서 보더 색상 변경
            ),
            hintText: '${hintText}',
            hintStyle: f14Gray500w400,
            prefixIcon: Padding(
              padding:  EdgeInsets.only(left: 8),
              child: SvgPicture.asset('${icon}',fit: BoxFit.none),
            )
        ),
      ),
    );
  }
}