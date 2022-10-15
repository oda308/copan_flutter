import 'package:copan_flutter/data/expense/expense.dart';
import 'package:copan_flutter/data/expense/expense_category.dart';
import 'package:copan_flutter/data/local/db/dao.dart';

List<Expense> convertExpensesTableToExpenses(
    List<ExpenseTable> expenseTableEntries) {
  final expenses = <Expense>[];

  for (final entry in expenseTableEntries) {
    final expense = Expense(
      price: entry.price,
      categoryId: CategoryId.values[entry.categoryId],
      createDate: entry.createDate,
      description: entry.description,
      expenseUuid: entry.expenseUuid,
    );
    expenses.add(expense);
  }

  return expenses;
}
