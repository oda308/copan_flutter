import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/page/home.dart';
import 'app/page/home_with_tab_bar.dart';
import 'app/page/input_expense.dart';
import 'app/page/payment_ratio.dart';
import 'app/page/scanner.dart';
import 'app/page/select_category.dart';
import 'app/page/shared_setting.dart';
import 'app/page/sharing.dart';
import 'data/api/fetch_all_expenses.dart';
import 'data/expense/expense.dart';
import 'data/user.dart';
import 'notifier/notifier.dart';
import 'providers/expenses_provider.dart';
import 'providers/selected_month_provider.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await User().init();

  final expenses = await fetchAllExpenses();

  expensesProvider = StateNotifierProvider<ExpenseStateNotifier, List<Expense>>(
    (ref) => ExpenseStateNotifier(expenses: expenses),
  );

  runApp(
    ProviderScope(
      overrides: <Override>[selectedMonthProvider, expensesProvider],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        theme: AppTheme.light().themeData,
        darkTheme: AppTheme.dark().themeData,
        home: User().isShared ? const HomeWithTabBar() : const Home(),
        routes: <String, WidgetBuilder>{
          '/inputExpense': (context) => const InputExpense(),
          '/selectCategory': (context) => const SelectCategory(),
          '/sharedSetting': (context) => const SharedSetting(),
          '/sharing': (context) => const Sharing(),
          '/scanner': (context) => const Scanner(),
          '/paymentRatio': (context) => const PaymentRatio(),
        },
      );
}
