
import 'package:flutter/material.dart';
import 'package:tripStory/core/theme/app_colors.dart';
import 'package:tripStory/core/theme/app_text_styles.dart';


class AppTheme {
  static ThemeData get light => _buildTheme(brightness: Brightness.light);
  static ThemeData get dark => _buildTheme(brightness: Brightness.dark);

  static ThemeData _buildTheme({required Brightness brightness}) {

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: Colors.white,
      extensions: <ThemeExtension<dynamic>>[
        _appColorScheme,
        _appTextTheme,
      ],
    );
  }

  static const _appColorScheme = AppColors(
        white: Color(0xFFFFFFFF),
        red: Color(0xFFFF4D4F),
        yellow: Color(0xFFFFCC00),
        green: Color(0xFF27AE60),
        blue: Color(0xFF4C90FF),
        gray900: Color(0xFF212121),
        gray800: Color(0xFF424242),
        gray700: Color(0xFF616161),
        gray600: Color(0xFF757575),
        gray500: Color(0xFF9E9E9E),
        gray400: Color(0xFFBDBDBD),
        gray300: Color(0xFFE0E0E0),
        gray200: Color(0xFFEEEEEE),
        gray100: Color(0xFFF5F5F5),
        gray50: Color(0xFFFAFAFA),
        neutral100: Color(0xFFF4F4F4),
        neutral300: Color(0xFFCCCCCC),
  );

  static final _baseTextStyle = TextStyle(
    fontFamily: "Pretendard",
    color: _appColorScheme.gray900,
  );

  static final _appTextTheme = AppTextStyles(
    title1: _baseTextStyle.copyWith(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      height: 1.334,
      letterSpacing: -0.972,
    ),
    title2: _baseTextStyle.copyWith(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 1.358,
      letterSpacing: -0.661,
    ),
    title3: _baseTextStyle.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.334,
      letterSpacing: -0.552,
    ),
    heading1: _baseTextStyle.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      height: 1.364,
      letterSpacing: -0.427,
    ),
    heading2: _baseTextStyle.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      height: 1.4,
      letterSpacing: -0.24,
    ),
    headline3: _baseTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.445,
      letterSpacing: -0.036,
    ),
    body1Normal: _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.5,
      letterSpacing: 0.0912,
    ),
    body1Reading: _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.625,
      letterSpacing: 0.0912,
    ),
    body2Normal: _baseTextStyle.copyWith(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      height: 1.467,
      letterSpacing: 0.144,
    ),
    body2Reading: _baseTextStyle.copyWith(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      height: 1.6,
      letterSpacing: 0.144,
    ),
    label1Normal: _baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.429,
      letterSpacing: 0.203,
    ),
    label1Reading: _baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.571,
      letterSpacing: 0.203,
    ),
    caption1: _baseTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.334,
      letterSpacing: 0.3024,
    ),
    caption2: _baseTextStyle.copyWith(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      height: 1.273,
      letterSpacing: 0.3411,
    ),
  );
}


