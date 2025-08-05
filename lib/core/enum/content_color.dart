import 'dart:ui';

enum ContentColor {
  white,
  pastelBlue,
  mainRed,
  yellow,
  green;

  Color get color {
    switch (this) {
      case ContentColor.white:
        return const Color(0xFFFFFFFF);
      case ContentColor.pastelBlue:
        return const Color(0xFF5E91EE);
      case ContentColor.mainRed:
        return const Color(0xFFFF6187);
      case ContentColor.yellow:
        return const Color(0xFFF4DC59);
      case ContentColor.green:
        return const Color(0xFF83CF75);
    }
  }
}
