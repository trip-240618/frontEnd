import 'package:flutter/material.dart';

class TextSpanHelper {
  TextSpanHelper._();

  /// String -> "10/15" 주고 / 구분자 지어주면 분리 할 수 있는 헬퍼함수
  static TextSpan toSplitText({
    required String text,
    required Pattern delimiter,
    required TextStyle firstStyle,
    required TextStyle secondStyle,
    TextStyle? delimiterStyle,
    bool includeDelimiter = true,
  }) {
    final delimiterStr = delimiter is RegExp ? "" : delimiter.toString();

    final parts = text.split(delimiter);
    final firstText = parts.isNotEmpty ? parts[0].trim() : "";
    final secondText = parts.length > 1 ? parts[1].trim() : "";

    final children = <InlineSpan>[
      TextSpan(
        text: firstText,
        style: firstStyle,
      ),
    ];

    if (secondText.isNotEmpty) {
      if (includeDelimiter && delimiterStr.isNotEmpty) {
        children.add(TextSpan(
          text: delimiterStr,
          style: delimiterStyle ?? secondStyle,
        ));
      }
      children.add(TextSpan(text: secondText, style: secondStyle));
    }

    return TextSpan(children: children);
  }
}
