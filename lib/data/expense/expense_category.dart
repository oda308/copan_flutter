import 'package:flutter/material.dart';

enum CategoryId {
  food,
  dailyNecessities,
  electricity,
  gas,
  waterSupply,
  communication,
  transportation,
  medicalCare,
  rent,
  others,
}

class ExpenseCategory {
  CategoryId id; // ユニークID(インクリメントで管理)
  String name; // 費目名
  IconData icon; // アイコン
  Color? iconColor; // アイコンの色

  ExpenseCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.iconColor,
  });
}
