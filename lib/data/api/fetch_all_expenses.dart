import 'dart:async';

import 'package:copan_flutter/data/expense/expense.dart';
import 'package:copan_flutter/main.dart';

import '../../data/user.dart';
import '../../requester/requester.dart';

Future<List<Expense>> fetchAllExpenses({required User user}) async {
  late final List<Expense> expenses;
  try {
    // webサーバから取得
    final expensesFromWeb = await Requester.instance.allExpensesRequester();

    expenses = convertWebAPIToExpenses(expensesFromWeb);

    // ToDo: 同期で持ってきたデータとローカルDBのデータの取り扱い
    //final expenses =
    //    convertExpensesTableToExpenses(await db.copanDB.getAllExpenseEntries);
  } catch (e) {
    expenses = [];
    rethrow;
  }

  return expenses;
}
