import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'common.dart';

class InputExpense extends StatelessWidget {
  const InputExpense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomSafeArea(content: InnerContents());
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
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                bottom: MediaQuery.of(context).size.width * 0.05,
                left: MediaQuery.of(context).size.width * 0.01,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final iconWidth = constraints.maxWidth * 0.2;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _Price(iconWidth: iconWidth),
                      _Category(iconWidth: iconWidth),
                      _Date(iconWidth: iconWidth),
                      _Content(iconWidth: iconWidth),
                    ],
                  );
                },
              ),
            ),
          ),
          const Expanded(
            flex: 2,
            child: _RecordButton(),
          ),
        ],
      ),
    );
  }
}

class _Price extends StatelessWidget {
  const _Price({required this.iconWidth, Key? key}) : super(key: key);

  final double iconWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: iconWidth,
          child: Column(
            children: const [
              Icon(Icons.price_change, color: Colors.grey),
              AutoSizeText(
                '金額',
                maxLines: 1,
              ),
            ],
          ),
        ),
        const Text('金額を入力するところ'),
      ],
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({required this.iconWidth, Key? key}) : super(key: key);

  final double iconWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: iconWidth,
          child: Column(
            children: const [
              Icon(Icons.dining, color: Colors.grey),
              AutoSizeText(
                'カテゴリ',
                maxLines: 1,
              ),
            ],
          ),
        ),
        const Text('食費'),
      ],
    );
  }
}

class _Date extends StatelessWidget {
  const _Date({required this.iconWidth, Key? key}) : super(key: key);

  final double iconWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: iconWidth,
          child: Column(
            children: const [
              Icon(Icons.calendar_today, color: Colors.grey),
              AutoSizeText(
                '日付',
                maxLines: 1,
              ),
            ],
          ),
        ),
        const Text('現在の日付'),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.iconWidth, Key? key}) : super(key: key);

  final double iconWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: iconWidth,
          child: Column(
            children: const [
              Icon(Icons.note_alt, color: Colors.grey),
              AutoSizeText('内容', maxLines: 1),
            ],
          ),
        ),
        const Text('内容を記入'),
      ],
    );
  }
}

class _RecordButton extends StatelessWidget {
  const _RecordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 6.0,
          padding: const EdgeInsets.only(
            top: 10,
            right: 20,
            bottom: 10,
            left: 20,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        icon: const Icon(Icons.edit),
        onPressed: () {
          // 計上する
        },
        label: const Text('計上する'),
      ),
    );
  }
}
