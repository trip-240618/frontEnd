import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripStory/common/text/common_text_form_field.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class ErrorTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String regexText;
  final String regexPattern;
  final void Function(String text, bool isValid)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;

  const ErrorTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.regexText,
    required this.regexPattern,
    this.onChanged,
    this.inputFormatters,
    this.leading,
    this.trailing,
    this.textStyle,
    this.contentPadding,
  });

  @override
  State<ErrorTextFormField> createState() => _ErrorTextFormFieldState();
}

class _ErrorTextFormFieldState extends State<ErrorTextFormField> {
  bool hasError = false;

  void _validate(String value) {
    final regex = RegExp(widget.regexPattern);

    setState(() {
      hasError = !(value.isEmpty || regex.hasMatch(value));
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      _validate(widget.controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextField(
          controller: widget.controller,
          hintText: widget.hintText,
          textStyle: widget.textStyle,
          trailing: widget.trailing,
          leading: widget.leading,
          contentPadding: widget.contentPadding,
          inputFormatters: widget.inputFormatters,
          onChanged: (text) {
            _validate(text);
            final regex = RegExp(widget.regexPattern);
            final isValid = text.isNotEmpty && regex.hasMatch(text);

            widget.onChanged?.call(text, isValid);
          },
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              widget.regexText,
              style: context.style.caption2.copyWith(
                color: context.color.errorColor,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {
      _validate(widget.controller.text);
    });
    super.dispose();
  }
}
