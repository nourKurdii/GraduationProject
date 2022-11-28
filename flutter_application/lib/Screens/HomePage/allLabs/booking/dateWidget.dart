import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/HomePage/allLabs/booking/timeExtention.dart';
import 'package:flutter_application/constants.dart';
//import 'package:flutter_application_1/core/theme/app_color.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.date,
    this.isSelected = false,
  });

  final DateTime date;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: isSelected ? kPrimaryColor:Color.fromARGB(255, 233, 227, 243),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            date.monthName,
            // style: Theme.of(context).textTheme.bodyMedium,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              // isSelected ? AppColor.white : null,
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              date.day.toString(),
              style: TextStyle(fontSize: 19, color: Colors.black)
              // Theme.of(context)
              //     .textTheme
              //     .bodyMedium
              //     ?.copyWith(color: isSelected ? AppColor.black : null)
              ,
            ),
          ),
        ],
      ),
    );
  }
}
