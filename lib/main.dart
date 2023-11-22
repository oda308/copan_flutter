import 'dart:io';

import 'package:copan_flutter/data/api/fetch_all_expenses.dart';
import 'package:copan_flutter/data/expense/expense.dart';
import 'package:copan_flutter/data/expense/expense_category.dart';
import 'package:copan_flutter/data/user.dart';
import 'package:copan_flutter/resources/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/expenses_provider.dart';
import '../../providers/selected_month_provider.dart';
import '../notifier/notifier.dart';
import 'app/page/expenses.dart';
import 'app/page/input_expense.dart';
import 'app/page/select_category.dart';
import 'theme/app_theme.dart';

const appTitle = '家計簿アプリCopan';
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

List<Expense> convertWebAPIToExpenses(List<dynamic> expensesFromWeb) {
  final expenses = <Expense>[];

  for (final entry in expensesFromWeb) {
    final dateTime = entry['date'].substring(0, 10);
    final formatter = DateFormat('yyyy-MM-dd');
    final formatted = formatter.parseStrict(dateTime as String);

    final category =
        expenseCategoryMap[CategoryId.values[entry['category'] as int]];

    // TODO: 不明なカテゴリとして扱った方が良いかもしれない
    if (category == null) {
      continue;
    }

    final expense = Expense(
      price: entry['price'] as int,
      category: category,
      createDate: formatted,
      description: entry['content'] as String,
      expenseUuid: entry['expense_uuid'] as String,
    );
    expenses.add(expense);
  }

  return expenses;
}
