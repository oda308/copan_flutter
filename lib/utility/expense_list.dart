import 'package:copan_flutter/data/expense/expense.dart';

int getTotalExpense(List<Expense> expensesList) {
  int totalExpense = 0;

  for (final expense in expensesList) {
    totalExpense += expense.price;
  }

  return totalExpense;
}
