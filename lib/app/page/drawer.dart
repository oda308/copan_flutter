import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> drawerItem = ['家計簿の共有', '支払割合', 'ログアウト'];

    return Drawer(
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(drawerItem[index]),
            );
          }),
    );
  }
}
