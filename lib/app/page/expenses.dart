import 'package:copan_flutter/app/widget/expenses_chart.dart';
import 'package:copan_flutter/app/widget/total_expense.dart';
import 'package:copan_flutter/utility/category_id.dart';
import 'package:copan_flutter/utility/expense.dart';
import 'package:copan_flutter/utility/expense_category.dart';
import 'package:copan_flutter/utility/format_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../../notifier/notifier.dart';
import '../../theme/app_theme.dart';
import '../widget/custom_card.dart';
import '../widget/custom_inkwell.dart';
import 'drawer.dart';

class Expenses extends StatelessWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('家計簿'),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: appTheme.appColors.secondaryBackground,
              height: 12,
            ),
          ),
          SliverToBoxAdapter(
            child: LayoutBuilder(builder: (context, constraint) {
              return Container(
                color: appTheme.appColors.secondaryBackground,
                child: CustomCard(
                  child: Column(children: [
                    const MonthSelector(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: ExpensesChart(),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TotalExpense(
                              width: constraint.maxWidth / 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ]),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: appTheme.appColors.secondaryBackground,
              height: 12,
            ),
          ),
          const _Expenses(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 8),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/inputExpense'),
        child: Icon(
          Icons.add,
          color: appTheme.appColors.secondaryText,
        ),
        backgroundColor: appTheme.appColors.accentColor,
      ),
    );
  }
}

class MonthSelector extends StatefulWidget {
  const MonthSelector({Key? key}) : super(key: key);

  @override
  _MonthSelectorState createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  late String showDateString;

  void showPrevMonth() {
    setState(() {
      index.decrementDateIndex();
      showDateString = updateDateString(index: index.index);
    });
  }

  void showNextMonth() {
    setState(() {
      index.incrementDateIndex();
      showDateString = updateDateString(index: index.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    showDateString = updateDateString(index: index.index);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomInkWell(icon: Icons.arrow_left, onTap: showPrevMonth),
                Text(
                  showDateString,
                  style: const TextStyle(fontSize: 18),
                ),
                CustomInkWell(icon: Icons.arrow_right, onTap: showNextMonth),
              ],
            ),
          );
        },
      ),
    );
  }

  String updateDateString({required int index}) {
    DateTime now = DateTime.now();
    DateTime targetDate = DateTime(now.year, now.month + index);
    String showDateString =
        targetDate.year.toString() + '年' + targetDate.month.toString() + '月~';

    return showDateString;
  }
}

class _Expenses extends ConsumerWidget {
  const _Expenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesList = ref.watch(expensesProvider);
    final expensesByCategoryList =
        getExpensesByCategory(expenses: expensesList);

    late final Widget widget;

    if (expensesByCategoryList.isNotEmpty) {
      widget = SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final expensesByCategory = expensesByCategoryList[index];
            late final String expenseName;
            late final IconData expenseCategoryIcon;
            late final Color? expenseCategoryIconColor;

            expenseName =
                expenseCategoryMap[expensesByCategory.categoryId]?.name ??
                    defaultExpenseCategory.name;
            expenseCategoryIcon =
                expenseCategoryMap[expensesByCategory.categoryId]?.icon ??
                    defaultExpenseCategory.icon;
            expenseCategoryIconColor =
                expenseCategoryMap[expensesByCategory.categoryId]?.iconColor ??
                    defaultExpenseCategory.iconColor;

            final listTiles = <ListTile>[];
            for (final expense in expensesByCategory.expenses) {
              final formattedPrice = getFormattedPrice(expense.price);
              listTiles.add(
                ListTile(
                  leading: Icon(
                    expenseCategoryIcon,
                    color: expenseCategoryIconColor,
                  ),
                  title: Text(
                    expense.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: Text(
                    '\u00A5' + formattedPrice,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              );
            }

            return ExpansionTile(
              leading: Icon(
                expenseCategoryIcon,
                color: expenseCategoryIconColor,
              ),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(expenseName),
                    Text('\u00A5 ' +
                        getFormattedPrice(expensesByCategory.totalPrice))
                  ]),
              children: listTiles,
            );
          },
          childCount: expensesByCategoryList.length,
        ),
      );
    } else {
      widget = const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: Center(
            child: Text(
              '今月の支出はありません',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    }
    return widget;
  }
}

List<ExpensesByCategory> getExpensesByCategory(
    {required List<Expense> expenses}) {
  final expensesByCategoryList = <ExpensesByCategory>[];

  for (final expense in expenses) {
    bool containsCategory = false;
    for (final expensesByCategory in expensesByCategoryList) {
      if (expensesByCategory.categoryId == expense.categoryId) {
        containsCategory = true;
        expensesByCategory.expenses.add(expense);
        expensesByCategory.totalPrice += expense.price;
      }
    }
    // まだ追加していないカテゴリをリストに加える
    if (!containsCategory) {
      expensesByCategoryList.add(ExpensesByCategory(
          categoryId: expense.categoryId,
          expenses: [expense],
          totalPrice: expense.price));
    }
  }
  return expensesByCategoryList;
}

class ExpensesByCategory {
  ExpensesByCategory({
    required this.categoryId,
    required this.expenses,
    required this.totalPrice,
  });

  CategoryId categoryId;
  List<Expense> expenses;
  int totalPrice;
}
