
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../util/color.dart';
import '../util/font.dart';

/// icon TextFromField
class TextIconFormFields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String icon;
  final ValueChanged? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  const TextIconFormFields(
      {Key? key,
        required this.controller,
        required this.hintText,
        required this.icon, this.onChanged, this.inputFormatters,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: gray50,
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: f16gray800w600,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            isDense: true,
            contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray200),
            ),
            fillColor: Colors.red,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray200), // 포커스된 상태에서 보더 색상 변경
            ),
            hintText: '${hintText}',
            hintStyle: f15gray800w500,
            prefixIcon: Padding(
              padding:  EdgeInsets.only(left: 8),
              child: SvgPicture.asset('${icon}',fit: BoxFit.none),
            )
        ),
      ),
    );
  }
}

/// icon TextFromField
class TextIconFormFields2 extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String icon;
  final ValueChanged? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  const TextIconFormFields2(
      {Key? key,
        required this.controller,
        required this.hintText,
        required this.icon, this.onChanged, this.inputFormatters,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: gray50,

      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: f16gray800w600,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            isDense: true,
            contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: controller.text.length==0?gray50:gray900,width: 1.5),
            ),
            fillColor: Colors.red,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray900,width: 1.5),
            ),
            hintText: '${hintText}',
            hintStyle: f15gray400w500,
            prefixIcon: Padding(
              padding:  EdgeInsets.only(left: 8),
              child: SvgPicture.asset('${icon}',fit: BoxFit.none),
            )
        ),
      ),
    );
  }
}
