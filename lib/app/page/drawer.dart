import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Colors.green,
            //child: SafeArea(
            //  top: false,
            //  bottom: false,
            child: const DrawerHeader(
              margin: EdgeInsets.only(bottom: 0),
              child: Text(
                '家計簿アプリCopan',
                style: TextStyle(color: Colors.white),
              ),
            ),
            //   ),
          ),
          ListTile(
            title: const Text('家計簿の共有'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('支払割合'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('ログアウト'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
