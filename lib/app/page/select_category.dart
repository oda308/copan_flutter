import 'package:copan_flutter/data/expense/expense_category.dart';
import 'package:copan_flutter/utility/l10n.dart';
import 'package:flutter/material.dart';

import '../../resources/expense_category.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n(context);
    final expenseCategoryList = expenseCategoryMap.values.toList();
    final itemCount = expenseCategoryMap.length;
    late final CategoryId selectedCategoryId;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.select_expense_category),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(
                  expenseCategoryList[index].icon,
                  color: expenseCategoryList[index].iconColor,
                ),
                title: Text(
                  expenseCategoryList[index].name,
                  style: const TextStyle(fontSize: 14),
                ),
                onTap: () {
                  selectedCategoryId = expenseCategoryList[index].id;
                  Navigator.of(context).pop(selectedCategoryId);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: itemCount,
          ),
        ),
      ),
    );
  }
}
