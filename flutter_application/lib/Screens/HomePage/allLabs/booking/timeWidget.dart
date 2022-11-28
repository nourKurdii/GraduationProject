import 'package:flutter/material.dart';
//import 'package:marahsebaproject/core/theme/app_color.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
    required this.time,
    this.isSelected = false,
  });

  final TimeOfDay time;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 233, 227, 243),
        //  isSelected ? AppColor.y : AppColor.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(right: 16),
      alignment: Alignment.center,
      child: Text(
        "${time.hour < 10 ? "0${time.hour}" : "${time.hour}"} : ${time.minute < 10 ? "0${time.minute}" : "${time.minute}"}",
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }
}
