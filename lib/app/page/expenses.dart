import 'package:copan_flutter/app/page/common.dart';
import 'package:copan_flutter/app/page/drawer.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class Expenses extends StatelessWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(content: _InnerContents());
  }
}

class _InnerContents extends StatelessWidget {
  const _InnerContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: AppDrawer(),
      body: MonthSelector(),
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
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    color: Colors.blue,
                    icon: const Icon(Icons.arrow_left),
                    onPressed: () {
                      showPrevMonth();
                    },
                  ),
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      showDateString,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  IconButton(
                    color: Colors.blue,
                    icon: const Icon(Icons.arrow_right),
                    onPressed: () {
                      showNextMonth();
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Placeholder(),
            ),
            Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.bottom,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.dining, color: Colors.grey),
                      title: Text('米'),
                      trailing: Text('\u00A5' + '1980'),
                    ),
                    ListTile(
                      leading: Icon(Icons.dining, color: Colors.grey),
                      title: Text('牛乳'),
                      trailing: Text('\u00A5' + '148'),
                    ),
                    ListTile(
                      leading: Icon(Icons.dining, color: Colors.grey),
                      title: Text('卵'),
                      trailing: Text('\u00A5' + '167'),
                    ),
                    ListTile(
                      leading: Icon(Icons.dining, color: Colors.grey),
                      title: Text('鶏肉'),
                      trailing: Text('\u00A5' + '350'),
                    ),
                    ListTile(
                      leading: Icon(Icons.dining, color: Colors.grey),
                      title: Text('レタス'),
                      trailing: Text('\u00A5' + '198'),
                    ),
                  ],
                )),
          ],
        ),
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
