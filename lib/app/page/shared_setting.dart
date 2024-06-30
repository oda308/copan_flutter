import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/user.dart';

class SharedSetting extends StatefulWidget {
  const SharedSetting({super.key});

  @override
  State<SharedSetting> createState() => _SharedSettingState();
}

class _SharedSettingState extends State<SharedSetting> {
  bool isShared = User().isShared;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('家計簿の共有切替')),
        body: SafeArea(
          child: ListTile(
            title: const Text('家計簿の共有をオンにする'),
            trailing: CupertinoSwitch(
              value: isShared,
              onChanged: (value) async {
                await User().updateSharedSetting(isShared: value);
                setState(() {
                  isShared = value;
                });
              },
            ),
          ),
        ),
      );
}
