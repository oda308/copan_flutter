import 'package:copan_flutter/app/widget/expenses_chart.dart';
import 'package:copan_flutter/app/widget/total_expense.dart';
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
        title: const Text('今月の支出'),
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
            final formattedPrice = getFormattedPrice(expensesList[index].price);
            late final IconData expenseCategoryIcon;
            late final Color? expenseCategoryIconColor;

            expenseCategoryIcon =
                expenseCategoryMap[expense.categoryId]?.icon ??
                    defaultExpenseCategory.icon;
            expenseCategoryIconColor =
                expenseCategoryMap[expense.categoryId]?.iconColor ??
                    defaultExpenseCategory.iconColor;

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
                '\u00A5' + formattedPrice,
                style: const TextStyle(fontSize: 14),
              ),
            );
          },
          childCount: expensesList.length,
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
