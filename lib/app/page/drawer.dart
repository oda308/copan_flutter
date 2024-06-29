import 'package:flutter/material.dart';

import '../../data/user.dart';
import '../../theme/app_theme.dart';
import '../../utility/l10n.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    final l10n = useL10n(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: appTheme.appColors.drawerBackground,
            ),
            child: const _HeaderContent(),
          ),
          ListTile(
            title: Text(l10n.shared_budget),
            onTap: () async {
              await Navigator.of(context).pushNamed('/sharing');
            },
          ),
          if (User().isShared)
            ListTile(
              title: Text(l10n.payment_ratio),
              onTap: () async {
                await Navigator.of(context).pushNamed('/paymentRatio');
              },
            ),
          // デバッグ用
          ListTile(
            title: const Text('共有状態の切替'),
            onTap: () async {
              await Navigator.of(context).pushNamed('/sharedSetting');
            },
          ),
        ],
      ),
    );
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
      children: <Widget>[
        Text(
          l10n.app_title,
          style: TextStyle(color: appTheme.appColors.secondaryText),
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            const Icon(
              Icons.account_circle,
              size: 32,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
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
