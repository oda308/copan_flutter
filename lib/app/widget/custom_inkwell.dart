import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          child: Icon(
            icon,
            color: Colors.green,
            size: 32,
          ),
          onTap: () {
            onTap();
          },
        ),
      ),
    );
  }
}
