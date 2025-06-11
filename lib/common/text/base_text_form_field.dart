import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? scrollPadding;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final int? maxLines;
  final EdgeInsets? contentPadding;

  const BaseTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.inputFormatters,
    this.scrollPadding,
    this.onFieldSubmitted,
    this.focusNode,
    this.hintStyle,
    this.textStyle,
    this.keyboardType,
    this.maxLines,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      style: textStyle ??
          const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      maxLines: maxLines,
      scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 12),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        hintText: hintText,
        hintStyle: hintStyle ??
            const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
      ),
    );
  }
}
