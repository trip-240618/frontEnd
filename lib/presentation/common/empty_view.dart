import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';

class EmptyView extends StatelessWidget {
  final String content;
  final TextStyle? fontStyle;

  const EmptyView({
    super.key,
    required this.content,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content,
        style: fontStyle ??
            context.style.heading1.copyWith(
              color: context.color.gray400,
              fontWeight: FontWeight.w500,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
