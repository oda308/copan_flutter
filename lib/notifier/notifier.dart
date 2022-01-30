import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utility/expense.dart';

var expensesProvider =
    StateNotifierProvider<ExpenseStateNotifier, List<Expense>>(
        (ref) => ExpenseStateNotifier());

class ExpenseStateNotifier extends StateNotifier<List<Expense>> {
  ExpenseStateNotifier() : super([]);

  void addExpense(Expense expense) {
    state = [...state, expense];
  }
}