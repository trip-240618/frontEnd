import 'package:flutter/material.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class CommonDivider extends StatelessWidget {
  final double thickness;
  final Color? color;
  final double? indent;
  final double? endIndent;

  const CommonDivider({
    super.key,
    this.thickness = 1.0,
    this.color,
    this.indent,
    this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      color: color ?? context.color.gray200,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
