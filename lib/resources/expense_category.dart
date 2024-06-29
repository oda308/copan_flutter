import 'package:flutter/material.dart';

import '../data/expense/expense_category.dart';

const ExpenseCategory defaultExpenseCategory = ExpenseCategory(
  id: CategoryId.food,
  name: '食費',
  icon: Icons.fastfood_outlined,
  iconColor: Colors.green,
);

final List<ExpenseCategory> expenseCategoryList = <ExpenseCategory>[
  defaultExpenseCategory,
  const ExpenseCategory(
    id: CategoryId.food,
    name: '食費',
    icon: Icons.fastfood_outlined,
    iconColor: Colors.green,
  ),
  const ExpenseCategory(
    id: CategoryId.dailyNecessities,
    name: '日用品',
    icon: Icons.cleaning_services_outlined,
    iconColor: Colors.blue,
  ),
  const ExpenseCategory(
    id: CategoryId.electricity,
    name: '電気代',
    icon: Icons.tungsten_outlined,
    iconColor: Colors.amber,
  ),
  const ExpenseCategory(
    id: CategoryId.gas,
    name: 'ガス代',
    icon: Icons.local_gas_station_outlined,
    iconColor: Colors.red,
  ),
  const ExpenseCategory(
    id: CategoryId.waterSupply,
    name: '水道代',
    icon: Icons.local_drink_outlined,
    iconColor: Colors.lightBlue,
  ),
  const ExpenseCategory(
    id: CategoryId.communication,
    name: '通信費',
    icon: Icons.phone_iphone_outlined,
    iconColor: Colors.indigo,
  ),
  const ExpenseCategory(
    id: CategoryId.transportation,
    name: '交通費',
    icon: Icons.train_outlined,
    iconColor: Colors.purple,
  ),
  const ExpenseCategory(
    id: CategoryId.medicalCare,
    name: '医療費',
    icon: Icons.medication_outlined,
    iconColor: Colors.orange,
  ),
  const ExpenseCategory(
    id: CategoryId.rent,
    name: '家賃',
    icon: Icons.home,
    iconColor: Colors.pinkAccent,
  ),
  const ExpenseCategory(
    id: CategoryId.others,
    name: 'その他',
    icon: Icons.pending_outlined,
    iconColor: Colors.grey,
  ),
];

final Map<CategoryId, ExpenseCategory> expenseCategoryMap =
    <CategoryId, ExpenseCategory>{
  for (ExpenseCategory category in expenseCategoryList) category.id: category,
};
