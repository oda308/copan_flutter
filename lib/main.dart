import 'package:flutter/material.dart';

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

class _Contents extends StatelessWidget {
  const _Contents({Key? key}) : super(key: key);

  final List<String> drawerItem = const ['家計簿の共有', '支払割合', 'ログアウト'];

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
              ),
              const Text('xx月'),
              IconButton(
                color: Colors.blue,
                icon: const Icon(Icons.arrow_right),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
