import 'package:flutter/material.dart';

class AppColors {
  AppColors({
    required this.primaryText,
    required this.secondaryText,
    required this.appBarBackground,
    required this.drawerBackground,
    required this.primaryBackground,
    required this.secondaryBackground,
    required this.accentColor,
  });

  factory AppColors.light() => AppColors(
      primaryText: Colors.black,
      secondaryText: Colors.white,
      appBarBackground: Colors.white,
      drawerBackground: Colors.green,
      primaryBackground: Colors.white,
      secondaryBackground: const Color(0xffECECEC),
      accentColor: Colors.green,
    );

  factory AppColors.dark() => AppColors(
      primaryText: Colors.black,
      secondaryText: Colors.white,
      appBarBackground: Colors.white,
      drawerBackground: Colors.green,
      primaryBackground: Colors.white,
      secondaryBackground: const Color(0xffECECEC),
      accentColor: Colors.green,
    );

  final Color primaryText;
  final Color secondaryText;
  final Color appBarBackground;
  final Color drawerBackground;
  final Color primaryBackground;
  final Color secondaryBackground;
  final Color accentColor;
}
