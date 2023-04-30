import 'package:flutter/material.dart';

import '../../data/local/db/dao.dart' as db;
import '../../data/user.dart';
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
            child: DrawerHeader(
              margin: const EdgeInsets.only(bottom: 0),
              child: Column(
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
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          User.instance?.email ?? '',
                          style: TextStyle(
                              color: appTheme.appColors.secondaryText),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10))
                ],
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
            onTap: () async {
              db.copanDB.deleteUser();
              await Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
