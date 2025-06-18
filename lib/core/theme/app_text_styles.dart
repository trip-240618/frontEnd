import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle title1;
  final TextStyle title2;
  final TextStyle title3;
  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle headline3;
  final TextStyle body1Normal;
  final TextStyle body1Reading;
  final TextStyle body2Normal;
  final TextStyle body2Reading;
  final TextStyle label1Normal;
  final TextStyle label1Reading;
  final TextStyle caption1;
  final TextStyle caption2;

  const AppTextStyles({
    required this.title1,
    required this.title2,
    required this.title3,
    required this.heading1,
    required this.heading2,
    required this.headline3,
    required this.body1Normal,
    required this.body1Reading,
    required this.body2Normal,
    required this.body2Reading,
    required this.label1Normal,
    required this.label1Reading,
    required this.caption1,
    required this.caption2,
  });

  @override
  AppTextStyles copyWith() => this;

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) => this;
}
