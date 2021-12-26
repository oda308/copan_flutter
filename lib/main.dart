import 'package:flutter/material.dart';

import 'app/page/date.dart';
import 'app/page/input_expense.dart';
import 'app/page/expenses.dart';

final index = DateIndex();
const appTitle = '家計簿Copan';

void main() {
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
        });
  }
}
