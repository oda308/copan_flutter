import 'package:copan_flutter/app/page/drawer.dart';
import 'package:copan_flutter/app/page/expenses.dart';
import 'package:copan_flutter/theme/app_theme.dart';
import 'package:copan_flutter/utility/l10n.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    final l10n = useL10n(context);
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('家計簿'),
            bottom: TabBar(tabs: [
              Tab(text: l10n.shared),
              Tab(text: l10n.private),
            ]),
          ),
          drawer: const AppDrawer(),
          body: SafeArea(
            bottom: false,
            child: TabBarView(children: [
              Expenses(),
              Expenses(),
            ]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).pushNamed('/inputExpense'),
            backgroundColor: appTheme.appColors.accentColor,
            child: Icon(
              Icons.add,
              color: appTheme.appColors.secondaryText,
            ),
          ),
        ));
  }
}
