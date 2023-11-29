import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/expenses_provider.dart';
import '../../providers/selected_month_provider.dart';
import '../data/expense/expense.dart';

class ExpenseStateNotifier extends StateNotifier<List<Expense>> {
  ExpenseStateNotifier({
    required List<Expense> expenses,
  }) : super(expenses);

  void initExpenses(List<Expense> expenses) {
    state = expenses;
  }

  void add(Expense expense) {
    state = [...state, expense];
  }

  void delete(String expenseUuid) {
    state.removeWhere((Expense expense) {
      print(expense.expenseUuid);
      print(expenseUuid);
      return expense.expenseUuid == expenseUuid;
    });
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
