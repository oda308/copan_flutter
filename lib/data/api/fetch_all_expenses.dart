import 'dart:async';

import 'package:intl/intl.dart';

import '../../requester/requester.dart';
import '../../resources/expense_category.dart';
import '../expense/expense.dart';
import '../expense/expense_category.dart';

Future<List<Expense>> fetchAllExpenses() async {
  final fetched = await Requester.instance.allExpensesRequester();
  final expenses = toExpenses(fetched: fetched);
  return expenses;
}

List<Expense> toExpenses({required List<dynamic> fetched}) {
  final expenses = <Expense>[];

  for (final entry in fetched) {
    final dateTime = (entry['date'] as String).substring(0, 10);
    final formatter = DateFormat('yyyy-MM-dd');
    final formatted = formatter.parseStrict(dateTime);

    final category =
        expenseCategoryMap[CategoryId.values[entry['category'] as int]];

    // TODO(oda308): 不明なカテゴリとして扱った方が良いかもしれない
    if (category == null) {
      continue;
    }

    final expense = Expense(
      price: entry['price'] as int,
      category: category,
      createDate: formatted,
      description: entry['content'] as String,
      expenseUuid: entry['expense_uuid'] as String? ?? '',
    );
    expenses.add(expense);
  }

  return expenses;
}
