import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notifier/notifier.dart';
import '../../utility/expense_list.dart';
import '../../utility/format_price.dart';

class TotalExpense extends ConsumerWidget {
  const TotalExpense({required this.width, Key? key}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesList = ref.watch(expensesProvider);
    final totalExpense = getTotalExpense(expensesList);
    final totalExpenseString = getFormattedPrice(totalExpense);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '支出',
              style: TextStyle(fontSize: 16),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "\u00a5 $totalExpenseString",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
