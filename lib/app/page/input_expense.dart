import 'package:copan_flutter/data/expense/expense_category.dart';
import 'package:copan_flutter/requester/requester.dart';
import 'package:copan_flutter/utility/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/expense/expense.dart';
import '../../providers/expenses_provider.dart';
import '../../theme/app_theme.dart';

class InputExpense extends StatefulWidget {
  const InputExpense({super.key});

  @override
  State<InputExpense> createState() => _InputExpenseState();
}

class _InputExpenseState extends State<InputExpense> {
  Expense inputted = Expense();

  @override
  Widget build(BuildContext context) {
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
              _Price(inputted: inputted, updateInputted: updateInputted),
              _Category(inputted: inputted, updateInputted: updateInputted),
              _Date(inputted: inputted, updateInputted: updateInputted),
              _Content(inputted: inputted, updateInputted: updateInputted),
              _RecordButton(inputted: inputted),
            ],
          ),
        ),
      ),
    );
  }

  void updateInputted({required Expense inputted}) {
    setState(() {
      this.inputted = inputted;
    });
  }
}

class _Price extends StatelessWidget {
  const _Price({required this.inputted, required this.updateInputted});

  final Expense inputted;
  final Function updateInputted;

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
            final updated =
                inputted.copyWith(price: int.parse(value == '' ? '0' : value));
            updateInputted(inputted: updated);
          },
        ),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({
    required this.inputted,
    required this.updateInputted,
  });

  final Expense inputted;
  final Function updateInputted;

  @override
  Widget build(BuildContext context) {
    final category = inputted.category;

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
            final updated = inputted.copyWith(category: selectedCategory);
            updateInputted(inputted: updated);
          }
        },
      ),
    );
  }
}

class _Date extends StatelessWidget {
  const _Date({
    required this.inputted,
    required this.updateInputted,
  });

  final Expense inputted;
  final Function updateInputted;

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
          child: Icon(Icons.calendar_today, color: Colors.green),
        ),
        title: Text(
            "${inputted.createDate.year}年${inputted.createDate.month}月${inputted.createDate.day}日"),
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: inputted.createDate,
            firstDate: DateTime(2021),
            lastDate: DateTime(2032),
            helpText: l10n.selected_purchase_date,
            cancelText: l10n.cancel,
            errorFormatText: l10n.invalid_date,
          );
          if (picked != null) {
            final updated = inputted.copyWith(createDate: picked);
            updateInputted(inputted: updated);
          }
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.inputted,
    required this.updateInputted,
  });

  final Expense inputted;
  final Function updateInputted;

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
            final updated = inputted.copyWith(description: value);
            updateInputted(inputted: updated);
          },
        ),
      ),
    );
  }
}

class _RecordButton extends ConsumerStatefulWidget {
  const _RecordButton({
    required this.inputted,
  });

  final Expense inputted;

  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends ConsumerState<_RecordButton> {
  @override
  void initState() {
    super.initState();
    ref.read(expensesProvider);
  }

  // 0円で計上する場合は計上理由を残すと思われるので
  // 金額とメモどちらも入力がなかった場合は計上ボタンをdisableにする
  bool get _isDisabled {
    return widget.inputted.price == 0 && widget.inputted.description == '';
  }

  double get _opacity => _isDisabled ? 0.6 : 1;

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    final l10n = useL10n(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Container(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  appTheme.appColors.accentColor.withOpacity(_opacity),
              elevation: _isDisabled ? null : 0,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              splashFactory: _isDisabled ? NoSplash.splashFactory : null,
            ),
            onPressed: () {
              Navigator.of(context).pop();

              // 空だった場合は内容の項目に費目を入れる
              if (widget.inputted.description == '') {
                widget.inputted
                    .copyWith(description: widget.inputted.category.name);
              }

              Requester.instance.inputExpenseRequester(
                price: widget.inputted.price,
                categoryId: widget.inputted.category.id.index,
                description: widget.inputted.description,
                date: widget.inputted.createDate,
                expenseUuid: widget.inputted.expenseUuid,
              );

              ref.read(expensesProvider.notifier).add(widget.inputted);
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
