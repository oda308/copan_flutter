import 'package:copan_flutter/app/page/drawer.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../main.dart';
import 'common.dart';

class InputExpense extends StatelessWidget {
  const InputExpense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(content: InnerContents());
  }
}

class InnerContents extends StatelessWidget {
  const InnerContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('費目の追加'),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          bottom: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.01,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          final iconWidth = constraints.maxWidth * 0.2;

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: iconWidth,
                    child: Column(
                      children: [
                        Icon(Icons.price_change, color: Colors.grey),
                        AutoSizeText(
                          '金額',
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Text('金額を入力するところ'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: iconWidth,
                    child: Column(
                      children: [
                        Icon(Icons.dining, color: Colors.grey),
                        AutoSizeText(
                          'カテゴリ',
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Text('食費'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: iconWidth,
                    child: Column(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey),
                        AutoSizeText(
                          '日付',
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Text('現在の日付'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: iconWidth,
                    child: Column(
                      children: [
                        Icon(Icons.note_alt, color: Colors.grey),
                        AutoSizeText('内容', maxLines: 1),
                      ],
                    ),
                  ),
                  Text('内容を記入'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: iconWidth,
                    child: Column(
                      children: [
                        Icon(Icons.person, color: Colors.grey),
                        AutoSizeText('払う人', maxLines: 1),
                      ],
                    ),
                  ),
                  Text('払う人の表示'),
                ],
              ),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 6.0,
                    padding: EdgeInsets.only(
                      top: 10,
                      right: 20,
                      bottom: 10,
                      left: 20,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // 計上する
                  },
                  label: const Text('計上する'),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
