import 'package:flutter/material.dart';

import 'app/page/date.dart';

final index = DateIndex();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const _Contents(),
    );
  }
}

class _Contents extends StatefulWidget {
  const _Contents({Key? key}) : super(key: key);

  @override
  __ContentsState createState() => __ContentsState();
}

class __ContentsState extends State<_Contents> {
  @override
  Widget build(BuildContext context) {
    const List<String> drawerItem = const ['家計簿の共有', '支払割合', 'ログアウト'];

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
        title: const Text('家計簿アプリCopan'),
      ),
      drawer: Drawer(
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(drawerItem[index]),
              );
            }),
      ),
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
