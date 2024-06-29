import '../data/expense/expense.dart';

int getTotalExpense(List<Expense> expensesList) {
  var totalExpense = 0;

  for (final expense in expensesList) {
    totalExpense += expense.price;
  }

  return totalExpense;
}
