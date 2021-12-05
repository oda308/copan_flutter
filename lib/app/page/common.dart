import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  const CustomSafeArea({required this.content, Key? key}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(bottom: false, child: content),
    );
  }
}
