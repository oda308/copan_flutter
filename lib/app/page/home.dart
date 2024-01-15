import 'package:copan_flutter/app/page/drawer.dart';
import 'package:copan_flutter/app/page/expenses.dart';
import 'package:copan_flutter/theme/app_theme.dart';
import 'package:flutter/material.dart';

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
      body: SafeArea(
        bottom: false,
        child: Expenses(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/inputExpense'),
        backgroundColor: appTheme.appColors.accentColor,
        child: Icon(
          Icons.add,
          color: appTheme.appColors.secondaryText,
        ),
      ),
    );
  }
}
