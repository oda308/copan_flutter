import 'package:copan_flutter/data/expense/expense_category.dart';
import 'package:copan_flutter/requester/requester.dart';
import 'package:copan_flutter/utility/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/expense/expense.dart';
import '../../notifier/notifier.dart';
import '../../providers/expenses_provider.dart';
import '../../providers/selected_month_provider.dart';
import '../../theme/app_theme.dart';
import '../../utility/format_price.dart';
import '../widget/custom_card.dart';
import '../widget/custom_inkwell.dart';
import '../widget/expenses_chart.dart';
import '../widget/total_expense.dart';
import 'drawer.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

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
            child: SizedBox(height: 96),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/inputExpense'),
        backgroundColor: appTheme.appColors.accentColor,
        child: Icon(
          Icons.add,
          color: appTheme.appColors.secondaryText,
        ),
      ),
    );
  }
}

class MonthSelector extends ConsumerStatefulWidget {
  const MonthSelector({super.key});

  @override
  MonthSelectorState createState() => MonthSelectorState();
}

class MonthSelectorState extends ConsumerState<MonthSelector> {
  late String showDateString;

  @override
  void initState() {
    super.initState();
    ref.read(selectedMonthProvider);
  }

  void showPrevMonth() {
    var selectedMonth = ref.watch(selectedMonthProvider);
    ref.read(selectedMonthProvider.notifier).state =
        DateTime(selectedMonth.year, selectedMonth.month - 1);
  }

  void showNextMonth() {
    var selectedMonth = ref.watch(selectedMonthProvider);
    ref.read(selectedMonthProvider.notifier).state =
        DateTime(selectedMonth.year, selectedMonth.month + 1);
  }

  @override
  Widget build(BuildContext context) {
    final targetMonth = ref.watch(selectedMonthProvider);
    final dateString = getDateString(targetMonth: targetMonth);
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
                  dateString,
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

  String getDateString({required DateTime targetMonth}) {
    String showDateString = '${targetMonth.year}年${targetMonth.month}月~';

    return showDateString;
  }
}

class _Expenses extends ConsumerWidget {
  const _Expenses();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n(context);
    final expensesList = ref.watch(filteredExpensesProvider);
    final expensesByCategoryList =
        getExpensesByCategory(expenses: expensesList);

    late final Widget widget;

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
                    children: [
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
                  onTap: () {
                    _showDeleteDialog(
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
                    children: [
                      Text(expensesByCategory.category.name),
                      Text(
                          '\u00A5 ${getFormattedPrice(expensesByCategory.totalPrice)}')
                    ]),
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
          padding: EdgeInsets.symmetric(vertical: 32),
          child: Center(
            child: Text(
              l10n.no_expenses_this_month,
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
      if (expensesByCategory.category.id == expense.category.id) {
        containsCategory = true;
        expensesByCategory.expenses.add(expense);
        expensesByCategory.totalPrice += expense.price;
      }
    }
    // まだ追加していないカテゴリをリストに加える
    if (!containsCategory) {
      expensesByCategoryList.add(ExpensesByCategory(
          category: expense.category,
          expenses: [expense],
          totalPrice: expense.price));
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

String _getMonthAndDay(DateTime date) {
  return "${date.month}/${date.day}";
}

Future<void> _showDeleteDialog({
  required BuildContext context,
  required Function deleteAction,
}) async {
  final l10n = useL10n(context);
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Text(l10n.deletion_confirmation),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(l10n.yes),
            onPressed: () {
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
      );
    },
  );
}
