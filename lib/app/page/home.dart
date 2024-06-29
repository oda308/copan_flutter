import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'drawer.dart';
import 'expenses.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('家計簿'),
      ),
      drawer: const AppDrawer(),
      body: const SafeArea(
        bottom: false,
        child: Expenses(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => Navigator.of(context).pushNamed('/inputExpense'),
        backgroundColor: appTheme.appColors.accentColor,
        child: Icon(
          Icons.add,
          color: appTheme.appColors.secondaryText,
        ),
      ),
    );
  }
}
