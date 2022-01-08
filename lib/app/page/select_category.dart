import 'package:copan_flutter/main.dart';
import 'package:flutter/material.dart';
import '../utility/expense_category.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenseCategoryList = ExpenseCategoryList().get();
    final itemCount = expenseCategoryList.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('カテゴリの選択'),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(expenseCategoryList[index].iconData),
                  title: Text(expenseCategoryList[index].name),
                  onTap: () {
                    selectedCategoryId = expenseCategoryList[index].id;
                    Navigator.of(context).pop();
                  },
                );
              }),
        ),
      ),
    );
  }
}
