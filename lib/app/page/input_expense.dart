import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/local/db/dao.dart' as db;
import '../../notifier/notifier.dart';
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
    final categoryId = widget.inputted.categoryId;

    expenseCategoryMap[categoryId];

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: ListTile(
        leading: SizedBox(
          height: double.infinity,
          child: Icon(
            expenseCategoryMap[categoryId]?.icon ?? defaultExpenseCategory.icon,
            color: expenseCategoryMap[categoryId]?.iconColor ??
                defaultExpenseCategory.iconColor,
          ),
        ),
        title: Text(
          expenseCategoryMap[categoryId]!.name,
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

            // 空だった場合は内容の項目に費目を入れる
            if (inputted.description == '') {
              inputted.description =
                  expenseCategoryMap[inputted.categoryId]?.name ??
                      defaultExpenseCategory.name;
            }

            // requestを送信, DBに保存
            _request(
              price: inputted.price,
              categoryId: inputted.categoryId.index,
              description: inputted.description,
              date: inputted.createDate,
            );

            db.copanDB.addExpense(db.ExpensesTableCompanion(
              price: drift.Value(inputted.price),
              categoryId: drift.Value(inputted.categoryId.index),
              description: drift.Value(inputted.description),
              criateDate: drift.Value(inputted.createDate),
            ));

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

void _request({
  required int price,
  required int categoryId,
  required String description,
  required DateTime date,
}) async {
  final expense = <String, dynamic>{
    "action": "insertExpense",
    "price": price,
    "categoryId": categoryId,
    "description": description,
    "date": date.toString(),
    "inputUserId": 1,
  };
  String url = "http://10.0.2.2:5500";
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode(expense);

  http.Response resp =
      await http.post(Uri.parse(url), headers: headers, body: body);

  if (resp.statusCode != 200) {
    throw AssertionError("Failed get response");
  }

  print(resp);
}
