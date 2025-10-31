import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/text/base_text_form_field.dart';

class TextAreaFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final Color? borderColor;
  final double? height;
  final int? maxTextLength;
  final TextInputType? keyboardType;
  final EdgeInsets? scrollPadding;

  const TextAreaFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.inputFormatters,
    this.textStyle,
    this.contentPadding,
    this.backgroundColor,
    this.focusNode,
    this.borderColor,
    this.height,
    this.maxTextLength,
    this.keyboardType,
    this.scrollPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.color.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor ?? context.color.gray200),
      ),
      child: Column(
        children: [
          Expanded(
            child: BaseTextFormField(
              controller: controller,
              focusNode: focusNode,
              hintText: hintText,
              onChanged: onChanged,
              inputFormatters: inputFormatters,
              textStyle: textStyle,
              contentPadding: contentPadding,
              keyboardType: keyboardType,
              scrollPadding: scrollPadding,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${controller.text.length}",
                  style: context.style.caption2.copyWith(
                    color: controller.text.isEmpty ? context.color.gray400 : context.color.gray800,
                  ),
                ),
                Text(
                  "/$maxTextLength",
                  style: context.style.caption2.copyWith(
                    color: context.color.gray400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
