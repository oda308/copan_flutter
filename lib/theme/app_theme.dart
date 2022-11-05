import 'package:flutter/material.dart';

import 'app_color.dart';

AppTheme getAppTheme(BuildContext context) {
  return _isDarkMode(context) ? AppTheme.dark() : AppTheme.light();
}

bool _isDarkMode(BuildContext context) {
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
            titleTextStyle:
                TextStyle(color: AppColors.light().accentColor, fontSize: 16),
            backgroundColor: AppColors.light().appBarBackground,
            iconTheme: const IconThemeData.fallback()
                .copyWith(color: AppColors.light().accentColor),
          ),
          backgroundColor: AppColors.light().primaryBackground,
          colorScheme: const ColorScheme.light()
              .copyWith(primary: AppColors.light().accentColor)),
      appColors: AppColors.light(),
    );
  }

  factory AppTheme.dark() {
    return AppTheme(
      mode: ThemeMode.dark,
      themeData: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
            titleTextStyle:
                TextStyle(color: AppColors.light().accentColor, fontSize: 16),
            backgroundColor: AppColors.dark().appBarBackground,
            iconTheme: const IconThemeData.fallback()
                .copyWith(color: AppColors.dark().accentColor),
          ),
          backgroundColor: AppColors.dark().primaryBackground,
          colorScheme: const ColorScheme.dark()
              .copyWith(primary: AppColors.dark().accentColor)),
      appColors: AppColors.dark(),
    );
  }

  final ThemeMode mode;
  final ThemeData themeData;
  final AppColors appColors;
}
