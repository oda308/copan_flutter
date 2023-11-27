import 'package:copan_flutter/data/expense/expense_category.dart';
import 'package:copan_flutter/requester/requester.dart';
import 'package:copan_flutter/utility/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/expense/expense.dart';
import '../../providers/expenses_provider.dart';
import '../../theme/app_theme.dart';

class InputExpense extends StatelessWidget {
  const InputExpense({super.key});

  @override
  Widget build(BuildContext context) {
    final inputted = Expense();

    final l10n = useL10n(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.input_expense),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _Price(inputted: inputted),
              _Category(inputted: inputted),
              _Date(inputted: inputted),
              _Content(inputted: inputted),
              _RecordButton(inputted: inputted),
            ],
          ),
        ),
      ),
    );
  }
}

class _Price extends StatelessWidget {
  const _Price({
    required this.inputted,
  });

  final Expense inputted;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: ListTile(
        leading: const SizedBox(
          height: double.infinity,
          child: Icon(
            Icons.price_change,
            color: Colors.green,
          ),
        ),
        title: TextField(
          decoration: InputDecoration(
            labelText: l10n.amount,
            labelStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {
            // 数字以外が入力された場合に取得する空文字は無視する
            if (value != '') {
              inputted.price = int.parse(value);
            }
          },
        ),
      ),
    );
  }
}

class _Category extends StatefulWidget {
  const _Category({
    required this.inputted,
  });

  final Expense inputted;

  @override
  State<_Category> createState() => _CategoryState();
}

class _CategoryState extends State<_Category> {
  @override
  Widget build(BuildContext context) {
    final category = widget.inputted.category;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: ListTile(
        leading: SizedBox(
          height: double.infinity,
          child: Icon(
            category.icon,
            color: category.iconColor,
          ),
        ),
        title: Text(
          category.name,
          textAlign: TextAlign.left,
        ),
        onTap: () async {
          final selectedCategory =
              await Navigator.pushNamed(context, '/selectCategory')
                  as ExpenseCategory?;
          if (selectedCategory != null) {
            setState(() {
              widget.inputted.category = selectedCategory;
            });
          }
        },
      ),
    );
  }
}

class _Date extends StatefulWidget {
  const _Date({
    required this.inputted,
  });

  final Expense inputted;

  @override
  State<_Date> createState() => _DateState();
}

class _DateState extends State<_Date> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: ListTile(
        leading: const SizedBox(
          height: double.infinity,
          child: Icon(Icons.calendar_today, color: Colors.green),
        ),
        title: Text(
            "${widget.inputted.createDate.year}年${widget.inputted.createDate.month}月${widget.inputted.createDate.day}日"),
        onTap: () {
          _selectDate(context);
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final l10n = useL10n(context);
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.inputted.createDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2032),
      helpText: l10n.selected_purchase_date,
      cancelText: l10n.cancel,
      errorFormatText: l10n.invalid_date,
    );
    if (picked != null) {
      setState(() => widget.inputted.createDate = picked);
    }
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.inputted,
  });

  final Expense inputted;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: ListTile(
        leading: const SizedBox(
          height: double.infinity,
          child: Icon(Icons.note_alt, color: Colors.green),
        ),
        title: TextField(
          decoration: InputDecoration(
            labelText: l10n.memo,
            labelStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          textAlign: TextAlign.left,
          onChanged: (value) {
            inputted.description = value;
          },
        ),
      ),
    );
  }
}

class _RecordButton extends ConsumerWidget {
  const _RecordButton({
    required this.inputted,
  });

  final Expense inputted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = getAppTheme(context);
    final l10n = useL10n(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Container(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: appTheme.appColors.accentColor,
              elevation: 1.0,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
            ),
            onPressed: () {
              Navigator.of(context).pop();

              // 空だった場合は内容の項目に費目を入れる
              if (inputted.description == '') {
                inputted.description = inputted.category.name;
              }

              // requestを送信, DBに保存
              Requester.instance.inputExpenseRequester(
                price: inputted.price,
                categoryId: inputted.category.id.index,
                description: inputted.description,
                date: inputted.createDate,
                expenseUuid: inputted.expenseUuid,
              );

              ref.read(expensesProvider.notifier).addExpense(inputted);
            },
            child: Text(
              l10n.record_expense,
              style: TextStyle(
                color: appTheme.appColors.secondaryText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
