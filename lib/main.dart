import 'package:flutter/material.dart';

import 'app/page/date.dart';
import 'app/page/input_expense.dart';
import 'app/page/expenses.dart';
import 'app/page/select_category.dart';
import 'app/utility/expense_category.dart';

final index = DateIndex();
const appTitle = '家計簿アプリCopan';
// TODO(odaki): 仮で何の費目を選択しているかの状態を持つ変数を定義しておく
var selectedCategoryId = 1;

void main() {
  initCategoryExpense(); // 費目の取得
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const Expenses(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => const Expenses(),
          '/inputExpense': (BuildContext context) => const InputExpense(),
          '/selectCategory': (BuildContext context) => const SelectCategory(),
        });
  }
}
