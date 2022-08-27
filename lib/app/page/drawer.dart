import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: appTheme.appColors.drawerBackground,
            //child: SafeArea(
            //  top: false,
            //  bottom: false,
            child: DrawerHeader(
              margin: const EdgeInsets.only(bottom: 0),
              child: Text(
                '家計簿アプリCopan',
                style: TextStyle(color: appTheme.appColors.secondaryText),
              ),
            ),
            //   ),
          ),
          ListTile(
            title: const Text('家計簿の共有'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('支払割合'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('ログアウト'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/login'),
          ),
        ],
      ),
    );
  }
}
