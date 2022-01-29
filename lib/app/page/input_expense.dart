import 'package:copan_flutter/app/utility/expense_category.dart';
import 'package:copan_flutter/main.dart';
import 'package:copan_flutter/theme/app_theme.dart';
import 'package:flutter/material.dart';

class InputExpense extends StatelessWidget {
  const InputExpense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('支出の入力'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              _Price(),
              _Category(),
              _Date(),
              _Content(),
              _RecordButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Price extends StatelessWidget {
  const _Price({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: ListTile(
        leading: SizedBox(
          height: double.infinity,
          child: Icon(
            Icons.price_change,
            color: Colors.grey,
          ),
        ),
        title: TextField(
          decoration: InputDecoration(
            labelText: '金額',
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenseCategoryList = ExpenseCategoryList().get();

    final expenseCategoryMap = {
      for (var expenseCategory in expenseCategoryList)
        '${expenseCategory.id}': expenseCategory,
    };

    final selectedCategory = expenseCategoryMap['$selectedCategoryId'];

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: ListTile(
        leading: SizedBox(
          height: double.infinity,
          child: Icon(selectedCategory.iconData, color: Colors.grey),
        ),
        title: Text(
          selectedCategory.name,
          textAlign: TextAlign.left,
        ),
        onTap: () {
          Navigator.pushNamed(context, '/selectCategory');
        },
      ),
    );
  }
}

class _Date extends StatefulWidget {
  const _Date({Key? key}) : super(key: key);

  @override
  State<_Date> createState() => _DateState();
}

class _DateState extends State<_Date> {
  var _date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: ListTile(
        leading: const SizedBox(
          height: double.infinity,
          child: Icon(Icons.calendar_today, color: Colors.grey),
        ),
        title: Text("${_date.year}年${_date.month}月${_date.day}日"),
        onTap: () {
          _selectDate(context);
        },
      ),
    );
  }

  Future _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2021),
        lastDate: DateTime(2032),
        helpText: '購入した日付を選択してください',
        cancelText: 'キャンセル',
        errorFormatText: 'その日付は指定できません');
    if (picked != null) {
      setState(() => _date = picked);
    }
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: ListTile(
        leading: SizedBox(
          height: double.infinity,
          child: Icon(Icons.note_alt, color: Colors.grey),
        ),
        title: TextField(
          decoration: InputDecoration(
            labelText: '内容',
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

class _RecordButton extends StatelessWidget {
  const _RecordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          },
          label: const Text(
            '計上する',
          ),
        ),
      ),
    );
  }
}
