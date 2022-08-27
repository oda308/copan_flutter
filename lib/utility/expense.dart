import 'category_id.dart';

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
