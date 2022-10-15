import 'package:copan_flutter/data/expense/expense_category.dart';

class Expense {
  Expense({
    required this.price,
    required this.categoryId,
    required this.createDate,
    required this.description,
    required this.expenseUuid,
  });

  int price;
  CategoryId categoryId;
  DateTime createDate;
  String description;
  String expenseUuid;
}
