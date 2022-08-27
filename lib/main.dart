import 'dart:convert';

import 'package:copan_flutter/utility/category_id.dart';
import 'package:copan_flutter/utility/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'app/page/expenses.dart';
import 'app/page/input_expense.dart';
import 'app/page/select_category.dart';
import 'notifier/notifier.dart';
import 'theme/app_theme.dart';
import 'utility/expense_category.dart';

const appTitle = '家計簿アプリCopan';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initCategoryExpense(); // 費目の取得

  late List<Expense> expenses;

  try {
    // webサーバから取得
    final expensesFromWeb = await _request(userId: 1);

    expenses = convertWebAPIToExpenses(expensesFromWeb);

    // ToDo: 同期で持ってきたデータとローカルDBのデータの取り扱い
    //final expenses =
    //    convertExpensesTableToExpenses(await db.copanDB.getAllExpenseEntries);
  } catch (e) {
    expenses = [];
    rethrow;
  } finally {
    final now = DateTime.now();
    final date = DateTime(now.year, now.month);

    runApp(ProviderScope(overrides: [
      selectedMonthProvider
          .overrideWithValue(SelectedMonthStateNotifier(date: date)),
      expensesProvider
          .overrideWithValue(ExpenseStateNotifier(expenses: expenses)),
    ], child: const MyApp()));
  }
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

Future<List<dynamic>> _request({
  required int userId,
}) async {
  final req = <String, dynamic>{
    "action": "getAllExpenses",
    "userId": userId,
  };
  String url = "http://10.0.2.2:5500";
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode(req);
  late List<dynamic> expenses;

  try {
    http.Response resp =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (resp.statusCode != 200) {
      throw AssertionError("Failed get response");
    }

    expenses = jsonDecode(resp.body) as List<dynamic>;
  } catch (e) {
    expenses = [];
    rethrow;
  }
  return expenses;
}

List<Expense> convertWebAPIToExpenses(expensesFromWeb) {
  final expenses = <Expense>[];

  for (final entry in expensesFromWeb) {
    final dateTime = entry['date'].substring(0, 10);
    final formatter = DateFormat('yyyy-MM-dd');
    final formatted = formatter.parseStrict(dateTime);

    final expense = Expense(
      price: entry['price'],
      categoryId: CategoryId.values[entry['category']],
      createDate: formatted,
      description: entry['content'],
      expenseUuid: entry['expense_uuid'],
    );
    expenses.add(expense);
  }

  return expenses;
}
