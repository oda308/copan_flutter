import 'package:flutter/material.dart';

import '../../data/user.dart';
import '../../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
        decoration: BoxDecoration(
          color: appTheme.appColors.drawerBackground,
        ),
        child: _HeaderContent(),
      ),
      ListTile(
        title: const Text('家計簿の共有'),
        onTap: () {},
      ),
      ListTile(
        title: const Text('支払割合'),
        onTap: () {},
      ),
    ]));
  }
}

class _HeaderContent extends StatelessWidget {
  const _HeaderContent();
  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '家計簿アプリCopan',
          style: TextStyle(color: appTheme.appColors.secondaryText),
        ),
        Spacer(),
        Row(
          children: [
            Icon(
              Icons.account_circle,
              size: 32,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                User().name,
                style: TextStyle(color: appTheme.appColors.secondaryText),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
