import 'package:copan_flutter/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/page/date.dart';
import 'app/page/expenses.dart';
import 'app/page/input_expense.dart';
import 'app/page/select_category.dart';
import 'utility/expense_category.dart';

final index = DateIndex();
const appTitle = '家計簿アプリCopan';

void main() {
  initCategoryExpense(); // 費目の取得
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        theme: AppTheme.light().themeData,
        darkTheme: AppTheme.dark().themeData,
        home: const Expenses(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => const Expenses(),
          '/inputExpense': (BuildContext context) => const InputExpense(),
          '/selectCategory': (BuildContext context) => const SelectCategory(),
        });
  }
}
