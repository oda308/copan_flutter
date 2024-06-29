import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    required this.icon,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    return SizedBox(
      width: 50,
      height: 50,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Icon(
            icon,
            color: appTheme.appColors.accentColor,
            size: 42,
          ),
        ),
      ),
    );
  }
}
