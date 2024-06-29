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
        body: SafeArea(
          child: ListTile(
            title: const Text('共有状態の切替'),
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
