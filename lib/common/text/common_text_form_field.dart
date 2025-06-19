import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/text/base_text_form_field.dart';
import 'package:tripStory/util/color.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.inputFormatters,
    this.leading,
    this.trailing,
    this.textStyle,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: gray200),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 8),
          ],
          Expanded(
            child: BaseTextFormField(
              controller: controller,
              hintText: hintText,
              onChanged: onChanged,
              inputFormatters: inputFormatters,
              textStyle: textStyle,
              contentPadding: contentPadding,
            ),
          ),
          if (trailing != null) ...[
            Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 16,
              ),
              child: trailing!,
            ),
          ],
        ],
      ),
    );
  }
}
