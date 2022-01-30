import 'package:copan_flutter/utility/categoryId.dart';

class Expense {
  Expense({
    required this.price,
    required this.categoryId,
    required this.createDate,
    required this.description,
  });

  int price;
  CategoryId categoryId;
  DateTime createDate;
  String description;
}
