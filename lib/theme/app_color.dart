import 'package:flutter/material.dart';

class AppColors {
  AppColors({
    required this.primaryText,
    required this.secondaryText,
    required this.appBarBackground,
    required this.drawerBackground,
    required this.primaryBackground,
    required this.accentColor,
  });

  factory AppColors.light() {
    return AppColors(
      primaryText: Colors.black,
      secondaryText: Colors.white,
      appBarBackground: Colors.white,
      drawerBackground: Colors.green,
      primaryBackground: Colors.white,
      accentColor: Colors.green,
    );
  }

  factory AppColors.dark() {
    return AppColors(
      primaryText: Colors.black,
      secondaryText: Colors.white,
      appBarBackground: Colors.white,
      drawerBackground: Colors.green,
      primaryBackground: Colors.white,
      accentColor: Colors.green,
    );
  }

  final Color primaryText;
  final Color secondaryText;
  final Color appBarBackground;
  final Color drawerBackground;
  final Color primaryBackground;
  final Color accentColor;
}
