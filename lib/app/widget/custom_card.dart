import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraint) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(1, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            width: constraint.maxWidth,
            child: child,
          ),
        ),
      );
}
