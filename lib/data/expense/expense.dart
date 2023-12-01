import 'package:copan_flutter/data/expense/expense_category.dart';
import 'package:copan_flutter/resources/expense_category.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

@immutable
class Expense {
  Expense({
    this.price = 0,
    this.category = defaultExpenseCategory,
    DateTime? createDate,
    this.description = '',
    String? expenseUuid,
  })  : createDate = createDate ?? DateTime.now(),
        expenseUuid = expenseUuid ?? Uuid().v4();

  final int price;
  final ExpenseCategory category;
  final DateTime createDate;
  final String description;
  final String expenseUuid;

  Expense copyWith(
      {int? price,
      ExpenseCategory? category,
      DateTime? createDate,
      String? description}) {
    return Expense(
      price: price ?? this.price,
      category: category ?? this.category,
      createDate: createDate,
      description: description ?? this.description,
      expenseUuid: expenseUuid,
    );
  }
}
