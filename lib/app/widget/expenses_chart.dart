import 'package:copan_flutter/notifier/notifier.dart';
import 'package:copan_flutter/utility/category_id.dart';
import 'package:copan_flutter/utility/expense.dart';
import 'package:copan_flutter/utility/expense_category.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensesChart extends ConsumerStatefulWidget {
  const ExpensesChart({
    Key? key,
  }) : super(key: key);

  @override
  _ExpensesChartState createState() => _ExpensesChartState();
}

class _ExpensesChartState extends ConsumerState<ExpensesChart> {
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    ref.read(expensesProvider);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      final width = constraint.maxWidth;
      final expensesList = ref.watch(expensesProvider);

      return SizedBox(
        width: constraint.maxWidth,
        height: constraint.maxWidth,
        child: PieChart(
          PieChartData(
              pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              }),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: width / 5,
              sections: showingSections(
                width: width,
                expensesList: expensesList,
              )),

          swapAnimationDuration: const Duration(milliseconds: 150), // Optional
          swapAnimationCurve: Curves.linear, // Optional
        ),
      );
    });
  }

  List<PieChartSectionData> showingSections({
    required double width,
    required List<Expense> expensesList,
  }) {
    final categoryTotalPriceMap = <CategoryId, PieChartCategoryTotal>{};
    int totalPrice = 0;

    for (var expense in expensesList) {
      totalPrice += expense.price;
      final price =
          categoryTotalPriceMap[expense.categoryId]?.categoryPrice ?? 0;
      categoryTotalPriceMap[expense.categoryId] = PieChartCategoryTotal(
        categoryId: expense.categoryId,
        categoryPrice: price + expense.price,
      );
    }

    final categoryTotalPriceList = categoryTotalPriceMap.values.toList();

    // 金額が多い順にsortする
    categoryTotalPriceList
        .sort((a, b) => -a.categoryPrice.compareTo(b.categoryPrice));

    if (categoryTotalPriceList.isNotEmpty) {
      return List.generate(categoryTotalPriceList.length, (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 16.0 : 12.0;
        final radius = isTouched ? width / 3 : width / 4;

        final expenseCategory =
            expenseCategoryMap[categoryTotalPriceList[i].categoryId];

        if (expenseCategory == null) {
          throw AssertionError("expenseCategory is null.");
        }

        late final String title;
        // 割合の少ないものは費目名を表示しない
        // タップした場合は表示する
        if (categoryTotalPriceList[i].categoryPrice / totalPrice < 0.07 &&
            !isTouched) {
          title = '';
        } else {
          title = expenseCategory.name;
        }
        return PieChartSectionData(
          color: expenseCategory.iconColor,
          value: categoryTotalPriceList[i].categoryPrice.toDouble(),
          title: title,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      });
    } else {
      return [
        PieChartSectionData(
          color: const Color.fromARGB(255, 218, 218, 218),
          value: 100,
          title: '',
          radius: width / 4,
          titleStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      ];
    }
  }
}

class PieChartCategoryTotal {
  PieChartCategoryTotal({
    required this.categoryId,
    required this.categoryPrice,
  });

  CategoryId categoryId;
  int categoryPrice;
}
