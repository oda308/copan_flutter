import 'package:copan_flutter/app/page/drawer.dart';
import 'package:copan_flutter/app/widget/custom_inkwell.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../widget/custom_card.dart';

class Expenses extends StatelessWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffECECEC),
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                MonthSelector(),
                _PieChart(),
                _Expenses(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/inputExpense'),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

class MonthSelector extends StatefulWidget {
  const MonthSelector({Key? key}) : super(key: key);

  @override
  _MonthSelectorState createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  late String showDateString;

  void showPrevMonth() {
    setState(() {
      index.decrementDateIndex();
      showDateString = updateDateString(index: index.index);
    });
  }

  void showNextMonth() {
    setState(() {
      index.incrementDateIndex();
      showDateString = updateDateString(index: index.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    showDateString = updateDateString(index: index.index);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomCard(
            widget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomInkWell(icon: Icons.arrow_left, onTap: showPrevMonth),
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      showDateString,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  CustomInkWell(icon: Icons.arrow_right, onTap: showNextMonth),
                ],
              ),
            ),
            maxWidth: constraints.maxWidth,
          );
        },
      ),
    );
  }

  String updateDateString({required int index}) {
    DateTime now = DateTime.now();
    DateTime targetDate = DateTime(now.year, now.month + index);
    String showDateString =
        targetDate.year.toString() + '年' + targetDate.month.toString() + '月~';

    return showDateString;
  }
}

class _PieChart extends StatelessWidget {
  const _PieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomCard(
            widget: SizedBox(
              height: constraints.maxWidth,
              width: constraints.maxWidth,
            ),
            maxWidth: constraints.maxWidth,
          );
        },
      ),
    );
  }
}

class _Expenses extends StatelessWidget {
  const _Expenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomCard(
            widget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.dining, color: Colors.grey),
                    title: Text('米'),
                    trailing: Text('\u00A5' '1980'),
                  ),
                  ListTile(
                    leading: Icon(Icons.dining, color: Colors.grey),
                    title: Text('牛乳'),
                    trailing: Text('\u00A5' '148'),
                  ),
                  ListTile(
                    leading: Icon(Icons.dining, color: Colors.grey),
                    title: Text('卵'),
                    trailing: Text('\u00A5' '167'),
                  ),
                  ListTile(
                    leading: Icon(Icons.dining, color: Colors.grey),
                    title: Text('鶏肉'),
                    trailing: Text('\u00A5' '350'),
                  ),
                  ListTile(
                    leading: Icon(Icons.dining, color: Colors.grey),
                    title: Text('レタス'),
                    trailing: Text('\u00A5' '198'),
                  ),
                  ListTile(
                    leading: Icon(Icons.dining, color: Colors.grey),
                    title: Text('歯ブラシ'),
                    trailing: Text('\u00A5' '138'),
                  ),
                  ListTile(
                    leading: Icon(Icons.dining, color: Colors.grey),
                    title: Text('電池'),
                    trailing: Text('\u00A5' '398'),
                  ),
                  ListTile(
                    leading: Icon(Icons.dining, color: Colors.grey),
                    title: Text('トイレットペーパー'),
                    trailing: Text('\u00A5' '468'),
                  ),
                ],
              ),
            ),
            maxWidth: constraints.maxWidth,
          );
        },
      ),
    );
  }
}
