import 'package:copan_flutter/notifier/notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
import '../../utility/category_id.dart';
import '../../utility/expense.dart';
import '../../utility/expense_category.dart';

class InputExpense extends StatelessWidget {
  const InputExpense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputted = Expense(
      price: 0,
      categoryId: CategoryId.food,
      createDate: DateTime.now(),
      description: '',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('支出の入力'),
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
    Key? key,
  }) : super(key: key);

  final Expense inputted;

  @override
  Widget build(BuildContext context) {
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
          decoration: const InputDecoration(
            labelText: '金額',
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
    Key? key,
  }) : super(key: key);

  final Expense inputted;

  @override
  State<_Category> createState() => _CategoryState();
}

class _CategoryState extends State<_Category> {
  @override
  Widget build(BuildContext context) {
    final expenseCategoryList = ExpenseCategoryList().get();

    final expenseCategoryMap = {
      for (var expenseCategory in expenseCategoryList)
        '${expenseCategory.id}': expenseCategory,
    };

    final selectedCategory =
        expenseCategoryMap['${widget.inputted.categoryId}'];

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: ListTile(
        leading: SizedBox(
          height: double.infinity,
          child: Icon(
            selectedCategory.icon,
            color: selectedCategory.iconColor,
          ),
        ),
        title: Text(
          selectedCategory.name,
          textAlign: TextAlign.left,
        ),
        onTap: () async {
          final selectedCategoryId =
              await Navigator.pushNamed(context, '/selectCategory')
                  as CategoryId?;
          if (selectedCategoryId != null) {
            setState(() {
              widget.inputted.categoryId = selectedCategoryId;
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
    Key? key,
  }) : super(key: key);

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

  Future _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: widget.inputted.createDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2032),
        helpText: '購入した日付を選択してください',
        cancelText: 'キャンセル',
        errorFormatText: 'その日付は指定できません');
    if (picked != null) {
      setState(() => widget.inputted.createDate = picked);
    }
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.inputted,
    Key? key,
  }) : super(key: key);

  final Expense inputted;

  @override
  Widget build(BuildContext context) {
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
          decoration: const InputDecoration(
            labelText: '内容',
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
    Key? key,
  }) : super(key: key);

  final Expense inputted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = getAppTheme(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: appTheme.appColors.accentColor,
            elevation: 6.0,
            padding: const EdgeInsets.only(
              top: 10,
              right: 20,
              bottom: 10,
              left: 20,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).pop();
            ref.read(expensesProvider.notifier).addExpense(inputted);
          },
          label: const Text(
            '計上する',
          ),
        ),
      ),
    );
  }
}
