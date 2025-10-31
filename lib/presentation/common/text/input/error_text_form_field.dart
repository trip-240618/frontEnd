import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/text/input/input_text_form_field.dart';

class ErrorTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final bool showError;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? leading;
  final String? leadingIconPath;
  final Color? leadingIconColor;

  final Widget? trailing;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final Color? backgroundColor;
  final TextInputType? keyboardType;

  const ErrorTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.errorText,
    required this.showError,
    this.onChanged,
    this.inputFormatters,
    this.leading,
    this.trailing,
    this.textStyle,
    this.contentPadding,
    this.backgroundColor,
    this.keyboardType,
    this.leadingIconPath,
    this.leadingIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTextField(
          controller: controller,
          hintText: hintText,
          backgroundColor: backgroundColor,
          textStyle: textStyle,
          trailing: trailing,
          leading: leading,
          leadingIconColor: leadingIconColor,
          leadingIconPath: leadingIconPath,
          contentPadding: contentPadding,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          keyboardType: keyboardType,
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              errorText,
              style: context.style.caption1.copyWith(
                color: context.color.errorColor,
              ),
            ),
          ),
      ],
    );
  }
}
