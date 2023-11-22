import 'dart:async';

import 'package:copan_flutter/data/expense/expense.dart';
import 'package:copan_flutter/data/expense/expense_category.dart';
import 'package:copan_flutter/resources/expense_category.dart';
import 'package:intl/intl.dart';

import '../../requester/requester.dart';

Future<List<Expense>> fetchAllExpenses() async {
  late final List<Expense> expenses;
  try {
    final fetched = await Requester.instance.allExpensesRequester();

    expenses = _toExpenses(fetched: fetched);
  } catch (e) {
    expenses = [];
    rethrow;
  }

  return expenses;
}

List<Expense> _toExpenses({required List<dynamic> fetched}) {
  final expenses = <Expense>[];

  for (final entry in fetched) {
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
