import 'dart:io';

import 'package:copan_flutter/app/page/login.dart';
import 'package:copan_flutter/app/page/sign_up.dart';
import 'package:copan_flutter/data/api/fetch_all_expenses.dart';
import 'package:copan_flutter/data/expense/expense.dart';
import 'package:copan_flutter/data/expense/expense_category.dart';
import 'package:copan_flutter/data/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/local/db/dao.dart' as db;
import 'app/page/expenses.dart';
import 'app/page/input_expense.dart';
import 'app/page/select_category.dart';
import 'notifier/notifier.dart';
import 'theme/app_theme.dart';

const appTitle = '家計簿アプリCopan';
User? user;
String uri =
    Platform.isAndroid ? "http://10.0.2.2:5500" : "http://127.0.0.1:5500";
late final StateNotifierProvider<SelectedMonthStateNotifier, DateTime>
    selectedMonthProvider;
late final StateNotifierProvider<ExpenseStateNotifier, List<Expense>>
    expensesProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userTable = await db.copanDB.getUser;
  if (userTable.first.email != null && userTable.first.accessToken != null) {
    user = User(userTable.first.email, userTable.first.accessToken);
  }

  List<Expense> expenses = [];

  if (user != null) {
    expenses = await fetchAllExpenses();
  }

  final now = DateTime.now();
  final date = DateTime(now.year, now.month);
  selectedMonthProvider =
      StateNotifierProvider<SelectedMonthStateNotifier, DateTime>(
          (ref) => SelectedMonthStateNotifier(date: date));
  expensesProvider = StateNotifierProvider<ExpenseStateNotifier, List<Expense>>(
      (ref) => ExpenseStateNotifier(expenses: expenses));

  runApp(ProviderScope(
      overrides: [selectedMonthProvider, expensesProvider],
      child: MyApp(user: user)));
}

class MyApp extends StatelessWidget {
  const MyApp({
    required this.user,
    Key? key,
  }) : super(key: key);

  final dynamic user;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        theme: AppTheme.light().themeData,
        darkTheme: AppTheme.dark().themeData,
        home: user != null ? const Expenses() : const Login(),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => const Login(),
          '/signUp': (BuildContext context) => const SignUp(),
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

    final expense = Expense(
      price: entry['price'] as int,
      categoryId: CategoryId.values[entry['category'] as int],
      createDate: formatted,
      description: entry['content'] as String,
      expenseUuid: entry['expense_uuid'] as String,
    );
    expenses.add(expense);
  }

  return expenses;
}
