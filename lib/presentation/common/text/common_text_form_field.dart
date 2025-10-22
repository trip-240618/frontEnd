import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/util/color.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/text/base_text_form_field.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onFieldSubmitted;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final Color? borderColor;
  final EdgeInsets? scrollPadding;
  final int? maxLines;
  final int? minLines;
  final bool? isFocusOnTapOutside;
  final TextInputType? keyboardType;
  final double? maxHeight;

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
    this.onFieldSubmitted,
    this.scrollPadding,
    this.maxLines,
    this.isFocusOnTapOutside,
    this.keyboardType,
    this.minLines,
    this.maxHeight,
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
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeight ?? double.infinity,
              ),
              child: BaseTextFormField(
                controller: controller,
                focusNode: focusNode,
                hintText: hintText,
                onChanged: onChanged,
                inputFormatters: inputFormatters,
                textStyle: textStyle,
                contentPadding: contentPadding,
                onFieldSubmitted: onFieldSubmitted,
                scrollPadding: scrollPadding,
                maxLines: maxLines,
                minLines: minLines,
                isFocusOnTapOutside: isFocusOnTapOutside,
                keyboardType: keyboardType,
              ),
            ),
          ),
          if (trailing != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: trailing!,
            ),
          ],
        ],
      ),
    );
  }
}
