import 'package:copan_flutter/data/expense/expense_category.dart';
import 'package:flutter/material.dart';

final defaultExpenseCategory = ExpenseCategory(
  id: CategoryId.food,
  name: '食費',
  icon: Icons.fastfood_outlined,
  iconColor: Colors.green,
);

final expenseCategoryList = [
  ExpenseCategory(
    id: CategoryId.food,
    name: '食費',
    icon: Icons.fastfood_outlined,
    iconColor: Colors.green,
  ),
  ExpenseCategory(
    id: CategoryId.dailyNecessities,
    name: '日用品',
    icon: Icons.cleaning_services_outlined,
    iconColor: Colors.blue,
  ),
  ExpenseCategory(
    id: CategoryId.electricity,
    name: '電気代',
    icon: Icons.tungsten_outlined,
    iconColor: Colors.amber,
  ),
  ExpenseCategory(
    id: CategoryId.gas,
    name: 'ガス代',
    icon: Icons.local_gas_station_outlined,
    iconColor: Colors.red,
  ),
  ExpenseCategory(
    id: CategoryId.waterSupply,
    name: '水道代',
    icon: Icons.local_drink_outlined,
    iconColor: Colors.lightBlue,
  ),
  ExpenseCategory(
    id: CategoryId.communication,
    name: '通信費',
    icon: Icons.phone_iphone_outlined,
    iconColor: Colors.indigo,
  ),
  ExpenseCategory(
    id: CategoryId.transportation,
    name: '交通費',
    icon: Icons.train_outlined,
    iconColor: Colors.purple,
  ),
  ExpenseCategory(
    id: CategoryId.medicalCare,
    name: '医療費',
    icon: Icons.medication_outlined,
    iconColor: Colors.orange,
  ),
  ExpenseCategory(
    id: CategoryId.rent,
    name: '家賃',
    icon: Icons.home,
    iconColor: Colors.pinkAccent,
  ),
  ExpenseCategory(
    id: CategoryId.others,
    name: 'その他',
    icon: Icons.pending_outlined,
    iconColor: Colors.grey,
  )
];

final Map<CategoryId, ExpenseCategory> expenseCategoryMap = {
  for (var category in expenseCategoryList) category.id: category
};
