import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/enum/button_type.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';

class BaseDialog extends StatelessWidget {
  final Widget content;
  final List<Widget> actions;
  final EdgeInsets contentPadding;

  const BaseDialog({
    super.key,
    required this.content,
    required this.actions,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      contentPadding: contentPadding,
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      content: SizedBox(
        width: context.screenWidth,
        child: content,
      ),
      actions: actions,
    );
  }
}
