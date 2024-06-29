import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/expense/expense.dart';
import '../providers/expenses_provider.dart';
import '../providers/selected_month_provider.dart';

class ExpenseStateNotifier extends StateNotifier<List<Expense>> {
  ExpenseStateNotifier({
    required List<Expense> expenses,
  }) : super(expenses);

  void add(Expense expense) {
    state = <Expense>[...state, expense];
  }

  void delete(String expenseUuid) {
    state = <Expense>[
      for (final Expense expense in state)
        if (expense.expenseUuid != expenseUuid) expense,
    ];
  }
}

class SelectedMonthStateNotifier extends StateNotifier<DateTime> {
  SelectedMonthStateNotifier({
    required DateTime date,
  }) : super(date);

  void initMonth() {
    state = DateTime.now();
  }

  void changeMonth(DateTime date) {
    state = date;
  }
}

// 選択されている月の費目だけ取得する
final Provider<List<Expense>> filteredExpensesProvider = Provider((ref) {
  final expenses = ref.watch(expensesProvider);
  final selectedMonth = ref.watch(selectedMonthProvider);

  final currentMonth = DateTime(selectedMonth.year, selectedMonth.month);
  final nextMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);

  return expenses
      .where(
        (expense) =>
            (expense.createDate.isAtSameMomentAs(currentMonth) ||
                expense.createDate.isAfter(currentMonth)) &&
            expense.createDate.isBefore(nextMonth),
      )
      .toList();
});
