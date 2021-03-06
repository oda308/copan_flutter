import 'package:copan_flutter/data/local/db/dao.dart';
import 'package:copan_flutter/utility/category_id.dart';
import 'package:copan_flutter/utility/expense.dart';

List<Expense> convertExpensesTableToExpenses(
    List<ExpenseTable> expenseTableEntries) {
  final expenses = <Expense>[];

  for (final entry in expenseTableEntries) {
    final expense = Expense(
      price: entry.price,
      categoryId: CategoryId.values[entry.categoryId],
      createDate: entry.criateDate,
      description: entry.description,
    );
    expenses.add(expense);
  }

  return expenses;
}
