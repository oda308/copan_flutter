import 'package:copan_flutter/app/page/common.dart';
import 'package:copan_flutter/app/page/drawer.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class Expenses extends StatelessWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(content: InnerContents());
  }
}

class InnerContents extends StatefulWidget {
  const InnerContents({Key? key}) : super(key: key);

  @override
  _InnerContentsState createState() => _InnerContentsState();
}

class _InnerContentsState extends State<InnerContents> {
  @override
  Widget build(BuildContext context) {
    String showDateString = updateDateString(index: index.index);

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                color: Colors.blue,
                icon: const Icon(Icons.arrow_left),
                onPressed: () {
                  showPrevMonth();
                },
              ),
              Text(showDateString),
              IconButton(
                color: Colors.blue,
                icon: const Icon(Icons.arrow_right),
                onPressed: () {
                  showNextMonth();
                },
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/inputExpense'),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
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
