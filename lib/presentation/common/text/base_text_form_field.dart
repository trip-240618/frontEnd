import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';

class BaseTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? scrollPadding;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final EdgeInsets? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final bool? isFocusOnTapOutside;

  const BaseTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.inputFormatters,
    this.scrollPadding,
    this.onFieldSubmitted,
    this.focusNode,
    this.textStyle,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.contentPadding,
    this.enabledBorder,
    this.focusedBorder,
    this.isFocusOnTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      style: textStyle ??
          context.style.body2Normal.copyWith(
            fontWeight: FontWeight.w500,
          ),
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLines: maxLines,
      minLines: minLines,
      scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
      onTapOutside: isFocusOnTapOutside ?? true ? (_) => FocusManager.instance.primaryFocus?.unfocus() : null,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
        enabledBorder: enabledBorder ?? OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: focusedBorder ?? OutlineInputBorder(borderSide: BorderSide.none),
        hintText: hintText,
        hintStyle: context.style.body2Normal.copyWith(
          color: context.color.gray400,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
