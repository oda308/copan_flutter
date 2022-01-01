import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.widget,
    required this.maxWidth,
    Key? key,
  }) : super(key: key);

  final Widget widget;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 3.0,
            offset: Offset(1, 3),
          ),
        ], borderRadius: BorderRadius.circular(4.0), color: Colors.white),
        width: maxWidth,
        child: widget);
  }
}
