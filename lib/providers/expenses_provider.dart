import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/expense/expense.dart';
import '../notifier/notifier.dart';

var expensesProvider =
    StateNotifierProvider<ExpenseStateNotifier, List<Expense>>(
        (ref) => ExpenseStateNotifier(expenses: []));
