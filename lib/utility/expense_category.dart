import 'package:flutter/material.dart';

import 'category_id.dart';

final defaultExpenseCategory = ExpenseCategory(
  id: CategoryId.food,
  name: '食費',
  icon: Icons.fastfood_outlined,
  iconColor: Colors.green,
);

final Map<CategoryId, ExpenseCategory> expenseCategoryMap = {
  CategoryId.food: ExpenseCategory(
    id: CategoryId.food,
    name: '食費',
    icon: Icons.fastfood_outlined,
    iconColor: Colors.green,
  ),
  CategoryId.dailyNecessities: ExpenseCategory(
    id: CategoryId.dailyNecessities,
    name: '日用品',
    icon: Icons.cleaning_services_outlined,
    iconColor: Colors.blue,
  ),
  CategoryId.electricity: ExpenseCategory(
    id: CategoryId.electricity,
    name: '電気代',
    icon: Icons.tungsten_outlined,
    iconColor: Colors.amber,
  ),
  CategoryId.gas: ExpenseCategory(
    id: CategoryId.gas,
    name: 'ガス代',
    icon: Icons.local_gas_station_outlined,
    iconColor: Colors.red,
  ),
  CategoryId.waterSupply: ExpenseCategory(
    id: CategoryId.waterSupply,
    name: '水道代',
    icon: Icons.local_drink_outlined,
    iconColor: Colors.lightBlue,
  ),
  CategoryId.communication: ExpenseCategory(
    id: CategoryId.communication,
    name: '通信費',
    icon: Icons.phone_iphone_outlined,
    iconColor: Colors.indigo,
  ),
  CategoryId.transportation: ExpenseCategory(
    id: CategoryId.transportation,
    name: '交通費',
    icon: Icons.train_outlined,
    iconColor: Colors.purple,
  ),
  CategoryId.medicalCare: ExpenseCategory(
    id: CategoryId.medicalCare,
    name: '医療費',
    icon: Icons.medication_outlined,
    iconColor: Colors.orange,
  ),
  CategoryId.rent: ExpenseCategory(
    id: CategoryId.rent,
    name: '家賃',
    icon: Icons.home,
    iconColor: Colors.pinkAccent,
  ),
  CategoryId.others: ExpenseCategory(
    id: CategoryId.others,
    name: 'その他',
    icon: Icons.pending_outlined,
    iconColor: Colors.grey,
  ),
};

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

class ExpenseCategoryList {
  static final List<ExpenseCategory> _items = <ExpenseCategory>[];
  static final ExpenseCategoryList _cache = ExpenseCategoryList._internal();

  ExpenseCategoryList._internal();

  factory ExpenseCategoryList() {
    return _cache;
  }

  set(ExpenseCategory category) => _items.add(category);
  List<ExpenseCategory> get getExpenseCategory => _items;
}

void initCategoryExpense() {
  // アプリ内で使用する費目を初期化する
  final expenseCategoryList = ExpenseCategoryList();

  expenseCategoryList.set(ExpenseCategory(
    id: CategoryId.food,
    name: '食費',
    icon: Icons.fastfood_outlined,
    iconColor: Colors.green,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: CategoryId.dailyNecessities,
    name: '日用品',
    icon: Icons.cleaning_services_outlined,
    iconColor: Colors.blue,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: CategoryId.electricity,
    name: '電気代',
    icon: Icons.tungsten_outlined,
    iconColor: Colors.amber,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: CategoryId.gas,
    name: 'ガス代',
    icon: Icons.local_gas_station_outlined,
    iconColor: Colors.red,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: CategoryId.waterSupply,
    name: '水道代',
    icon: Icons.local_drink_outlined,
    iconColor: Colors.lightBlue,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: CategoryId.communication,
    name: '通信費',
    icon: Icons.phone_iphone_outlined,
    iconColor: Colors.indigo,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: CategoryId.transportation,
    name: '交通費',
    icon: Icons.train_outlined,
    iconColor: Colors.purple,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: CategoryId.medicalCare,
    name: '医療費',
    icon: Icons.medication_outlined,
    iconColor: Colors.orange,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: CategoryId.rent,
    name: '家賃',
    icon: Icons.home,
    iconColor: Colors.pinkAccent,
  ));
  expenseCategoryList.set(ExpenseCategory(
    id: CategoryId.others,
    name: 'その他',
    icon: Icons.pending_outlined,
    iconColor: Colors.grey,
  ));
}
