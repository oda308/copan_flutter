import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Container(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 3.0,
              offset: Offset(1, 3),
            ),
          ], borderRadius: BorderRadius.circular(4.0), color: Colors.white),
          width: constraint.maxWidth,
          child: child,
        ),
      );
    });
  }
}
