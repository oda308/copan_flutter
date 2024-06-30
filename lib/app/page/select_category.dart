import 'package:flutter/material.dart';

import '../../data/expense/expense_category.dart';
import '../../resources/expense_category.dart';
import '../../utility/l10n.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n(context);
    final expenseCategoryList = expenseCategoryMap.values.toList();
    final itemCount = expenseCategoryMap.length;
    late ExpenseCategory selectedCategory;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(l10n.select_expense_category),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ListView.separated(
            itemBuilder: (context, index) => ListTile(
              leading: Icon(
                expenseCategoryList[index].icon,
                color: expenseCategoryList[index].iconColor,
              ),
              title: Text(
                expenseCategoryList[index].name,
                style: const TextStyle(fontSize: 14),
              ),
              onTap: () {
                selectedCategory = expenseCategoryList[index];
                Navigator.of(context).pop(selectedCategory);
              },
            ),
            separatorBuilder: (context, index) =>
                const Divider(color: Colors.grey),
            itemCount: itemCount,
          ),
        ),
      ),
    );
  }
}
