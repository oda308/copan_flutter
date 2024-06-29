import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utility/l10n.dart';
import 'drawer.dart';
import 'expenses.dart';

class HomeWithTabBar extends StatelessWidget {
  const HomeWithTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    final l10n = useL10n(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('家計簿'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: l10n.sharing),
              Tab(text: l10n.private),
            ],
          ),
        ),
        drawer: const AppDrawer(),
        body: const SafeArea(
          bottom: false,
          child: TabBarView(
            children: <Widget>[
              Expenses(),
              Expenses(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async =>
              Navigator.of(context).pushNamed('/inputExpense'),
          backgroundColor: appTheme.appColors.accentColor,
          child: Icon(
            Icons.add,
            color: appTheme.appColors.secondaryText,
          ),
        ),
      ),
    );
  }
}
