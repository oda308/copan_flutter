import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../resources/expense_category.dart';
import 'expense_category.dart';

@immutable
class Expense {
  Expense({
    this.price = 0,
    this.category = defaultExpenseCategory,
    DateTime? createDate,
    this.description = '',
    String? expenseUuid,
  })  : createDate = createDate ?? DateTime.now(),
        expenseUuid = expenseUuid ?? const Uuid().v4();

  final int price;
  final ExpenseCategory category;
  final DateTime createDate;
  final String description;
  final String expenseUuid;

  Expense copyWith({
    int? price,
    ExpenseCategory? category,
    DateTime? createDate,
    String? description,
  }) =>
      Expense(
        price: price ?? this.price,
        category: category ?? this.category,
        createDate: createDate,
        description: description ?? this.description,
        expenseUuid: expenseUuid,
      );
}
