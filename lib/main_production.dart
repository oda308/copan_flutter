import 'dart:io';

import 'package:copan_flutter/app/page/home.dart';
import 'package:copan_flutter/app/page/home_with_tab_bar.dart';
import 'package:copan_flutter/app/page/payment_ratio.dart';
import 'package:copan_flutter/app/page/scanner.dart';
import 'package:copan_flutter/app/page/shared_setting.dart';
import 'package:copan_flutter/app/page/sharing.dart';
import 'package:copan_flutter/data/api/fetch_all_expenses.dart';
import 'package:copan_flutter/data/expense/expense.dart';
import 'package:copan_flutter/data/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/expenses_provider.dart';
import '../../providers/selected_month_provider.dart';
import '../notifier/notifier.dart';
import 'app/page/input_expense.dart';
import 'app/page/select_category.dart';
import 'theme/app_theme.dart';

String uri =
    Platform.isAndroid ? "http://10.0.2.2:5500" : "http://127.0.0.1:5500";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await User().init();

  List<Expense> expenses = await fetchAllExpenses();

  expensesProvider = StateNotifierProvider<ExpenseStateNotifier, List<Expense>>(
      (ref) => ExpenseStateNotifier(expenses: expenses));

  runApp(ProviderScope(
      overrides: [selectedMonthProvider, expensesProvider], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        theme: AppTheme.light().themeData,
        darkTheme: AppTheme.dark().themeData,
        home: User().isShared ? HomeWithTabBar() : Home(),
        routes: <String, WidgetBuilder>{
          '/inputExpense': (BuildContext context) => const InputExpense(),
          '/selectCategory': (BuildContext context) => const SelectCategory(),
          '/sharedSetting': (BuildContext context) => SharedSetting(),
          '/sharing': (BuildContext context) => Sharing(),
          '/scanner': (BuildContext context) => Scanner(),
          '/paymentRatio': (BuildContext context) => PaymentRatio(),
        });
  }
}
