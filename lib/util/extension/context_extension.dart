import 'package:flutter/material.dart';
import 'package:tripStory/core/theme/app_colors.dart';
import 'package:tripStory/core/theme/app_text_styles.dart';

extension ContextExtension on BuildContext{
  /// Color Theme
  AppColors get color => Theme.of(this).extension<AppColors>()!;
  /// Text Style Theme
  AppTextStyles get style => Theme.of(this).extension<AppTextStyles>()!;

  /// Screen Size & Device Type
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  /// Safe Area Insets
  double get safeTop => MediaQuery.of(this).padding.top;
  double get safeBottom => MediaQuery.of(this).padding.bottom;

  /// Theme Mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}