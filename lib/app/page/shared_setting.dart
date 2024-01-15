import 'package:copan_flutter/data/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SharedSetting extends StatefulWidget {
  SharedSetting({super.key});

  @override
  State<SharedSetting> createState() => _SharedSettingState();
}

class _SharedSettingState extends State<SharedSetting> {
  var isShared = User().isShared;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListTile(
                leading: null,
                title: Text("共有家計簿の表示"),
                trailing: CupertinoSwitch(
                  value: isShared,
                  onChanged: (value) {
                    User().updateSharedSetting(isShared: value);
                    setState(() {
                      isShared = value;
                    });
                  },
                ))));
  }
}
