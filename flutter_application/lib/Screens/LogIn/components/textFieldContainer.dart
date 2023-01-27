import 'package:flutter/material.dart';
import '../../../constants.dart';

class textField extends StatelessWidget {
  final Widget child;
  final Color color;
  const textField({
    Key? key,
    required this.child, required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(29)),
      child: child,
    );
  }
}
