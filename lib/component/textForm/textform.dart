import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/core/util/color.dart';
import 'package:tripStory/core/util/font.dart';

/// 텍스트 필드
class TextFormFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final EdgeInsets? scrollPadding;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;

  const TextFormFieldComponent(
      {Key? key,
      required this.controller,
      this.onChanged,
      this.inputFormatters,
      required this.hintText,
      this.scrollPadding,
      this.onFieldSubmitted,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      style: f16gray800w600,
      onChanged: onChanged,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      scrollPadding: scrollPadding ?? EdgeInsets.all(20.0),
      onTapOutside: (e) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        hintText: '${hintText}',
        hintStyle: f14Gray500w400,
      ),
    );
  }
}

/// 외부 포커스 안줘도 되는 컴포넌트
class TextFormFieldComponent2 extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final EdgeInsets? scrollPadding;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;

  const TextFormFieldComponent2(
      {Key? key,
      required this.controller,
      this.onChanged,
      this.inputFormatters,
      required this.hintText,
      this.scrollPadding,
      this.onFieldSubmitted,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      style: f16gray800w600,
      onChanged: onChanged,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      scrollPadding: scrollPadding ?? EdgeInsets.all(20.0),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        hintText: '${hintText}',
        hintStyle: f14Gray500w400,
      ),
    );
  }
}

/// 아이콘 TextFromField
class TextIconFormFields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String icon;
  final ValueChanged? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final ColorFilter? colorFilter;
  final TextStyle? hintStyle;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool? isUnfocus;
  final TextInputType? textInputType;

  const TextIconFormFields({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.onChanged,
    this.inputFormatters,
    this.colorFilter,
    this.hintStyle,
    this.onFieldSubmitted,
    this.focusNode,
    this.isUnfocus,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: gray50,
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: f15gray800w500,
        onChanged: onChanged,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        inputFormatters: inputFormatters,
        keyboardType: textInputType,
        onTapOutside: (e) {
          if (isUnfocus != true) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray200),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray200), // 포커스된 상태에서 보더 색상 변경
            ),
            hintText: '${hintText}',
            hintStyle: hintStyle == null ? f15gray400w500 : hintStyle,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 8),
              child: SvgPicture.asset('${icon}', fit: BoxFit.none, colorFilter: colorFilter),
            )),
      ),
    );
  }
}

/// 아이콘 뒤에 배경
class TextIconBackFormFields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String icon;
  final ValueChanged? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final ColorFilter? colorFilter;
  final TextStyle? hintStyle;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool? isUnfocus;
  final TextInputType? textInputType;

  const TextIconBackFormFields({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.onChanged,
    this.inputFormatters,
    this.colorFilter,
    this.hintStyle,
    this.onFieldSubmitted,
    this.focusNode,
    this.isUnfocus,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: gray50,
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: f15gray800w500,
        onChanged: onChanged,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        inputFormatters: inputFormatters,
        keyboardType: textInputType,
        onTapOutside: (e) {
          if (isUnfocus != true) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: '${hintText}',
            hintStyle: hintStyle == null ? f15gray800w500 : hintStyle,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 8),
              child: SvgPicture.asset('${icon}', fit: BoxFit.none, colorFilter: colorFilter),
            )),
      ),
    );
  }
}

/// 메모 텍스트 필드
class TextMemoFormFields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? scrollPadding;
  final FocusNode? focusNode;
  final int? maxLine;
  final TextInputType? textInputType;

  const TextMemoFormFields({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.inputFormatters,
    this.scrollPadding,
    this.focusNode,
    this.maxLine,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      focusNode: focusNode,
      onTapOutside: (e) => FocusManager.instance.primaryFocus?.unfocus(),
      scrollPadding: scrollPadding ?? EdgeInsets.all(20.0),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        hintText: '${hintText}',
        hintStyle: f15gray400w500,
      ),
      keyboardType: textInputType,
      maxLines: null,
      inputFormatters: inputFormatters,
    );
  }
}

/// 초대 TextFromField
class TextIconFormFields2 extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String icon;
  final ValueChanged? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const TextIconFormFields2({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

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
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: controller.text.length == 0 ? gray50 : gray900, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: gray900, width: 1.5),
          ),
          hintText: '${hintText}',
          hintStyle: f15gray400w500,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 8),
            child: SvgPicture.asset('${icon}', fit: BoxFit.none),
          ),
        ),
      ),
    );
  }
}

/// 바텀시트 형태의 textForm필드
TextFormSheet(
    BuildContext context, String hintText, TextEditingController controller, FocusNode focusNode, VoidCallback onTap) {
  final ts = Get.put(TripState());
  Scaffold.of(context).showBottomSheet((BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x1AD4D4D4),
                offset: Offset(0, -3),
                blurRadius: 6,
              ),
              BoxShadow(
                color: Color(0x17D4D4D4),
                offset: Offset(0, -10),
                blurRadius: 10,
              ),
              BoxShadow(
                color: Color(0x0DD4D4D4),
                offset: Offset(0, -23),
                blurRadius: 14,
              ),
              BoxShadow(
                color: Color(0x03D4D4D4),
                offset: Offset(0, -40),
                blurRadius: 16,
              ),
              BoxShadow(
                color: Color(0x00D4D4D4),
                offset: Offset(0, -63),
                blurRadius: 18,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: gray50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: gray200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        onChanged: (con) {
                          setState(() {});
                        },
                        onFieldSubmitted: (value) {
                          onTap();
                        },
                        cursorColor: Color(ts.selectTripList[0]['labelColor']),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: hintText,
                          hintStyle: f15gray400w500,
                        ),
                        controller: controller,
                        focusNode: focusNode,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(18),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Text(
                        '${controller.text.length}',
                        style: controller.text.length > 0 ? f11Gray800w600 : f11Gray400w600,
                      ),
                    ),
                    Text('/18 ', style: f11Gray400w600),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          onTap();
                          if (focusNode.hasFocus) {
                            FocusScope.of(context).unfocus();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            'assets/icon/roundArrowRight.svg',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  });
}
