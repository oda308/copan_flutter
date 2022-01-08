import 'package:flutter/material.dart';

class ExpenseCategory {
  int id; // ユニークID(インクリメントで管理)
  String name; // 費目名
  IconData iconData; // アイコン

  ExpenseCategory(
      {required this.id, required this.name, required this.iconData});
}

class ExpenseCategoryList {
  static final List<ExpenseCategory> _items = <ExpenseCategory>[];
  static final ExpenseCategoryList _cache = ExpenseCategoryList._internal();

  ExpenseCategoryList._internal();

  factory ExpenseCategoryList() {
    return _cache;
  }

  set(ExpenseCategory category) => _items.add(category);
  get() => _items;
}

void initCategoryExpense() {
  // アプリ内で使用する費目を初期化する
  final expenseCategoryList = ExpenseCategoryList();

  expenseCategoryList.set(ExpenseCategory(
    id: 1,
    name: '食費',
    iconData: Icons.fastfood_outlined,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: 2,
    name: '日用品',
    iconData: Icons.cleaning_services_outlined,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: 3,
    name: '電気代',
    iconData: Icons.tungsten_outlined,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: 4,
    name: 'ガス代',
    iconData: Icons.local_gas_station_outlined,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: 5,
    name: '水道代',
    iconData: Icons.local_drink_outlined,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: 6,
    name: '通信費',
    iconData: Icons.phone_iphone_outlined,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: 7,
    name: '交通費',
    iconData: Icons.train_outlined,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: 8,
    name: '医療費',
    iconData: Icons.medication_outlined,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: 99999,
    name: 'その他',
    //pending
    iconData: Icons.pending_outlined,
  ));
}
