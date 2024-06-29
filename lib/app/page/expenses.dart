import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/expense/expense.dart';
import '../../data/expense/expense_category.dart';
import '../../notifier/notifier.dart';
import '../../providers/expenses_provider.dart';
import '../../providers/selected_month_provider.dart';
import '../../requester/requester.dart';
import '../../theme/app_theme.dart';
import '../../utility/format_price.dart';
import '../../utility/l10n.dart';
import '../widget/custom_card.dart';
import '../widget/custom_inkwell.dart';
import '../widget/expenses_chart.dart';
import '../widget/total_expense.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            color: appTheme.appColors.secondaryBackground,
            height: 12,
          ),
        ),
        SliverToBoxAdapter(
          child: LayoutBuilder(
            builder: (context, constraint) => ColoredBox(
              color: appTheme.appColors.secondaryBackground,
              child: CustomCard(
                child: Column(
                  children: <Widget>[
                    const MonthSelector(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: appTheme.appColors.secondaryBackground,
            height: 12,
          ),
        ),
        const _Expenses(),
        const SliverToBoxAdapter(
          child: SizedBox(height: 96),
        ),
      ],
    );
  }
}

class MonthSelector extends ConsumerWidget {
  const MonthSelector({super.key});

  void showPrevMonth(WidgetRef ref) {
    final selectedMonth = ref.watch(selectedMonthProvider);
    final prevMonth = DateTime(selectedMonth.year, selectedMonth.month - 1);
    ref.read(selectedMonthProvider.notifier).changeMonth(prevMonth);
  }

  void showNextMonth(WidgetRef ref) {
    final selectedMonth = ref.watch(selectedMonthProvider);
    final nextMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);
    ref.read(selectedMonthProvider.notifier).changeMonth(nextMonth);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetMonth = ref.watch(selectedMonthProvider);
    final dateString = getDateString(targetMonth: targetMonth);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomInkWell(
                icon: Icons.arrow_left,
                onTap: () {
                  showPrevMonth(ref);
                },
              ),
              Text(
                dateString,
                style: const TextStyle(fontSize: 18),
              ),
              CustomInkWell(
                icon: Icons.arrow_right,
                onTap: () {
                  showNextMonth(ref);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDateString({required DateTime targetMonth}) =>
      '${targetMonth.year}年${targetMonth.month}月~';
}

class _Expenses extends ConsumerWidget {
  const _Expenses();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n(context);
    final expensesList = ref.watch(filteredExpensesProvider);
    final expensesByCategoryList =
        getExpensesByCategory(expenses: expensesList);

    late Widget widget;

    if (expensesByCategoryList.isNotEmpty) {
      widget = SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final expensesByCategory = expensesByCategoryList[index];

            final listTiles = <ListTile>[];
            for (final expense in expensesByCategory.expenses) {
              final formattedPrice = getFormattedPrice(expense.price);
              listTiles.add(
                ListTile(
                  // leadingで上下中央によせるため、
                  // ColumnのmainAxisAlignmentで調整、回避している
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _getMonthAndDay(expense.createDate),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  title: Text(
                    expense.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: Text(
                    '\u00A5$formattedPrice',
                    style: const TextStyle(fontSize: 14),
                  ),
                  onTap: () async {
                    await _showDeleteDialog(
                      context: context,
                      deleteAction: () {
                        Requester.instance.deleteExpenseRequester(
                          expenseUuid: expense.expenseUuid,
                        );
                        ref
                            .read(expensesProvider.notifier)
                            .delete(expense.expenseUuid);
                      },
                    );
                  },
                ),
              );
            }

            return Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: Icon(
                  expensesByCategory.category.icon,
                  color: expensesByCategory.category.iconColor,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(expensesByCategory.category.name),
                    Text(
                      '''\u00A5 ${getFormattedPrice(expensesByCategory.totalPrice)}''',
                    ),
                  ],
                ),
                children: listTiles,
              ),
            );
          },
          childCount: expensesByCategoryList.length,
        ),
      );
    } else {
      widget = SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Center(
            child: Text(
              l10n.no_expenses_this_month,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    }
    return widget;
  }
}

List<ExpensesByCategory> getExpensesByCategory({
  required List<Expense> expenses,
}) {
  final expensesByCategoryList = <ExpensesByCategory>[];

  for (final expense in expenses) {
    var containsCategory = false;
    for (final expensesByCategory in expensesByCategoryList) {
      if (expensesByCategory.category.id == expense.category.id) {
        containsCategory = true;
        expensesByCategory.expenses.add(expense);
        expensesByCategory.totalPrice += expense.price;
      }
    }
    // まだ追加していないカテゴリをリストに加える
    if (!containsCategory) {
      expensesByCategoryList.add(
        ExpensesByCategory(
          category: expense.category,
          expenses: <Expense>[expense],
          totalPrice: expense.price,
        ),
      );
    }
  }
  return expensesByCategoryList;
}

class ExpensesByCategory {
  ExpensesByCategory({
    required this.category,
    required this.expenses,
    required this.totalPrice,
  });

  ExpenseCategory category;
  List<Expense> expenses;
  int totalPrice;
}

String _getMonthAndDay(DateTime date) => '${date.month}/${date.day}';

Future<void> _showDeleteDialog({
  required BuildContext context,
  required VoidCallback deleteAction,
}) async {
  final l10n = useL10n(context);
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: SingleChildScrollView(
        child: Text(l10n.deletion_confirmation),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(l10n.yes),
          onPressed: () async {
            Navigator.of(context).pop();
            deleteAction();
          },
        ),
        TextButton(
          child: Text(l10n.no),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
