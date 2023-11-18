import 'package:copan_flutter/providers/selected_month_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/expenses_provider.dart';

class SignUpCompleted extends ConsumerWidget {
  const SignUpCompleted({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('アカウントの作成'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("アカウントの作成が完了しました"),
            Padding(padding: EdgeInsets.only(bottom: 24)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  fixedSize: const Size.fromWidth(double.maxFinite)),
              onPressed: () async {
                print("家計簿に進む");
                ref.read(selectedMonthProvider.notifier).initMonth();
                ref.read(expensesProvider.notifier).initExpenses([]);
                await Navigator.of(context).pushReplacementNamed('/home');
              },
              child: const Text('家計簿に進む'),
            ),
          ],
        ),
      ),
    );
  }
}
