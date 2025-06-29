import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/text/base_text_form_field.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final Color? borderColor;

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
    this.backgroundColor,
    this.focusNode,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.color.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor ?? gray200),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            const SizedBox(width: 16),
            leading!,
          ],
          Expanded(
            child: BaseTextFormField(
              controller: controller,
              focusNode: focusNode,
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
