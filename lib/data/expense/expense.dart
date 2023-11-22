import 'package:copan_flutter/data/expense/expense_category.dart';
import 'package:copan_flutter/resources/expense_category.dart';
import 'package:uuid/uuid.dart';

// TODO: StateNotifierのステートとして使用するためimmutableにする
// https://riverpod.dev/ja/docs/providers/state_notifier_provider
class Expense {
  int price;
  ExpenseCategory category;
  DateTime createDate;
  String description;
  String expenseUuid;

  Expense({
    int? price,
    ExpenseCategory? category,
    DateTime? createDate,
    String? description,
    String? expenseUuid,
  })  : price = price ?? 0,
        category = category ?? defaultExpenseCategory,
        createDate = createDate ?? DateTime.now(),
        description = description ?? '',
        expenseUuid = expenseUuid ?? const Uuid().v4();
}
