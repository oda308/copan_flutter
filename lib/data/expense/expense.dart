import 'package:copan_flutter/data/expense/expense_category.dart';

// TODO: StateNotifierのステートとして使用するためimmutableにする
// https://riverpod.dev/ja/docs/providers/state_notifier_provider
class Expense {
  Expense({
    required this.price,
    required this.category,
    required this.createDate,
    required this.description,
    required this.expenseUuid,
  });

  int price;
  ExpenseCategory category;
  DateTime createDate;
  String description;
  String expenseUuid;
}
