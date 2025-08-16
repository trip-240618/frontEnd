import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';
import 'package:tripStory/presentation/common/text/common_text_form_field.dart';

class LeadingIconTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String leadingIconPath;
  final Color? iconColor;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onFieldSubmitted;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final Color? borderColor;
  final EdgeInsets? scrollPadding;
  final bool? isFocusOnTapOutside;

  const LeadingIconTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.leadingIconPath,
    this.iconColor,
    this.onChanged,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.textStyle,
    this.contentPadding,
    this.backgroundColor,
    this.focusNode,
    this.borderColor,
    this.scrollPadding,
    this.isFocusOnTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      controller: controller,
      hintText: hintText,
      leading: SizedBox(
        width: 20,
        height: 20,
        child: SvgIcon(
          assetPath: leadingIconPath,
          color: iconColor ?? context.color.gray700,
        ),
      ),
      isFocusOnTapOutside: isFocusOnTapOutside,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      textStyle: context.style.body2Normal.copyWith(
        color: context.color.gray800,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      backgroundColor: backgroundColor,
      focusNode: focusNode,
      borderColor: borderColor,
      scrollPadding: scrollPadding,
      maxLines: 1,
    );
  }
}
