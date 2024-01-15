import 'package:copan_flutter/utility/l10n.dart';
import 'package:flutter/material.dart';

import '../../data/user.dart';
import '../../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    final l10n = useL10n(context);
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
        decoration: BoxDecoration(
          color: appTheme.appColors.drawerBackground,
        ),
        child: _HeaderContent(),
      ),
      ListTile(
        title: Text(l10n.shared_budget),
        onTap: () {},
      ),
      ListTile(
        title: Text(l10n.payment_ratio),
        onTap: () {},
      ),
      // デバッグ用
      ListTile(
        title: Text("共有家計簿の表示切替"),
        onTap: () {
          Navigator.of(context).pushNamed('/sharedSetting');
        },
      ),
    ]));
  }
}

class _HeaderContent extends StatelessWidget {
  const _HeaderContent();
  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    final l10n = useL10n(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.app_title,
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
