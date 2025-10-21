import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';

class EmptyView extends StatelessWidget {
  final String content;

  const EmptyView({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content,
        style: context.style.heading2.copyWith(
          color: context.color.gray400,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
