import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/notifier.dart';

final selectedMonthProvider =
    StateNotifierProvider<SelectedMonthStateNotifier, DateTime>(
        (ref) => SelectedMonthStateNotifier(date: DateTime.now()));
