import 'package:flutter/material.dart';

import 'app_color.dart';

AppTheme getAppTheme(context) {
  return _isDarkMode(context) ? AppTheme.dark() : AppTheme.light();
}

bool _isDarkMode(context) {
  return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
}

class AppTheme {
  const AppTheme({
    required this.mode,
    required this.themeData,
    required this.appColors,
  });

  factory AppTheme.light() {
    return AppTheme(
      mode: ThemeMode.light,
      themeData: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.light().appBarBackground,
        ),
        backgroundColor: AppColors.light().primaryBackground,
      ),
      appColors: AppColors.light(),
    );
  }

  factory AppTheme.dark() {
    return AppTheme(
      mode: ThemeMode.dark,
      themeData: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.light().appBarBackground,
        ),
        backgroundColor: AppColors.light().primaryBackground,
      ),
      appColors: AppColors.dark(),
    );
  }

  final ThemeMode mode;
  final ThemeData themeData;
  final AppColors appColors;
}
