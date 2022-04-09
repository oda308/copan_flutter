import 'package:flutter/material.dart';

import '../../utility/category_id.dart';
import '../../utility/expense_category.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenseCategoryList = ExpenseCategoryList().get();
    final itemCount = expenseCategoryList.length;
    late final CategoryId selectedCategoryId;
    return Scaffold(
      appBar: AppBar(
        title: const Text('費目の選択'),
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
