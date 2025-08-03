import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color white;
  final Color black;
  final Color whiteEC;
  final Color red; // 기존 color 의 mainRed
  final Color yellow;
  final Color green;
  final Color blue; // 기존 color 의 pastelBlue

  final Color gray900;
  final Color gray800;
  final Color gray700;
  final Color gray600;
  final Color gray500;
  final Color gray400;
  final Color gray300;
  final Color gray200;
  final Color gray100;
  final Color gray50;
  final Color neutral100; // light background
  final Color neutral300; // divider / outline

  final Color errorColor;

  const AppColors({
    required this.white,
    required this.black,
    required this.whiteEC,
    required this.red,
    required this.yellow,
    required this.green,
    required this.blue,
    required this.gray900,
    required this.gray800,
    required this.gray700,
    required this.gray600,
    required this.gray500,
    required this.gray400,
    required this.gray300,
    required this.gray200,
    required this.gray100,
    required this.gray50,
    required this.neutral100,
    required this.neutral300,
    required this.errorColor,
  });

  @override
  AppColors copyWith() => this;

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) => this;
}
