import 'dart:ffi';

import 'package:copan_flutter/app/widget/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../../notifier/notifier.dart';
import '../../theme/app_theme.dart';
import '../../utility/expense_category.dart';
import '../widget/custom_inkwell.dart';
import '../widget/expenses_chart.dart';
import 'drawer.dart';

class Expenses extends StatelessWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    return Scaffold(
      backgroundColor: const Color(0xffECECEC),
      appBar: AppBar(
        title: const Text('今月の支出'),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(slivers: [
          const SliverToBoxAdapter(
            child: MonthSelector(),
          ),
          SliverToBoxAdapter(
            child: LayoutBuilder(builder: (context, constraint) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CustomCard(
                  maxWidth: constraint.maxWidth,
                  widget: Row(
                    children: [
                      ExpensesChart(width: constraint.maxWidth / 2),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '支出',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '\u00a5 123,123',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 64),
          ),
          const _Expenses(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 64),
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
                  style: const TextStyle(fontSize: 16),
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

    late final Widget widget;

    if (expensesList.isNotEmpty) {
      widget = SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final expense = expensesList[index];
            final price = expensesList[index].price;
            final List<ExpenseCategory> expenseCategoryList =
                ExpenseCategoryList().get();
            late final IconData expenseCategoryIcon;
            late final Color? expenseCategoryIconColor;

            for (final expenseCategory in expenseCategoryList) {
              if (expenseCategory.id == expense.categoryId) {
                expenseCategoryIcon = expenseCategory.icon;
                expenseCategoryIconColor = expenseCategory.iconColor;
              }
            }
            return ListTile(
              leading: Icon(
                expenseCategoryIcon,
                color: expenseCategoryIconColor,
              ),
              title: Text(
                expense.description,
                style: const TextStyle(fontSize: 14),
              ),
              trailing: Text(
                '\u00A5' + price.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            );
          },
          childCount: expensesList.length,
        ),
      );
    } else {
      widget = const SliverToBoxAdapter(
        child: Center(
          child: Text(
            '今月の支出はありません',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }
    return widget;
  }
}
