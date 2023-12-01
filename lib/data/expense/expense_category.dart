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

@immutable
class ExpenseCategory {
  const ExpenseCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.iconColor,
  });

  final CategoryId id; // ユニークID(インクリメントで管理)
  final String name; // 費目名
  final IconData icon; // アイコン
  final Color? iconColor; // アイコンの色
}
