import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utility/expense.dart';

final expensesProvider =
    StateNotifierProvider<ExpenseStateNotifier, List<Expense>>(
        (ref) => ExpenseStateNotifier());

class ExpenseStateNotifier extends StateNotifier<List<Expense>> {
  ExpenseStateNotifier({
    expenses,
  }) : super(expenses);

  void addExpense(Expense expense) {
    state = [...state, expense];
  }
}

final selectedMonthProvider =
    StateNotifierProvider<SelectedMonthStateNotifier, DateTime>(
        (ref) => SelectedMonthStateNotifier());

class SelectedMonthStateNotifier extends StateNotifier<DateTime> {
  SelectedMonthStateNotifier({
    date,
  }) : super(date);

  void changeMonth(DateTime date) {
    state = date;
  }
}

// 選択されている月の費目だけ取得する
final filteredExpensesProvider = Provider((ref) {
  final expenses = ref.watch(expensesProvider);
  final selectedMonth = ref.watch(selectedMonthProvider);

  final currentMonth = DateTime(selectedMonth.year, selectedMonth.month);
  final nextMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);

  return expenses
      .where((expense) =>
          (expense.createDate.isAtSameMomentAs(currentMonth) ||
              expense.createDate.isAfter(currentMonth)) &&
          expense.createDate.isBefore(nextMonth))
      .toList();
});
