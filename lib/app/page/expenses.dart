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
      body: const SafeArea(
        bottom: false,
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: MonthSelector(),
          ),
          SliverToBoxAdapter(
            child: _PieChart(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 64),
          ),
          _Expenses(),
          SliverToBoxAdapter(
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

class _PieChart extends StatelessWidget {
  const _PieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxWidth,
            child: CustomCard(
              maxWidth: constraints.maxWidth,
              widget: const ExpensesChart(),
            ),
          );
        },
      ),
    );
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
