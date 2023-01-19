// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'bookingCard.dart';

class bookingSection extends StatelessWidget {
  const bookingSection({
    Key? key,
    required this.name,
    required this.labName,
    required this.time,
    required this.date,
    required this.id,
    required this.status, required this.press, required this.labinfo,
  }) : super(key: key);
  final String name, labName, time, date;
  final String id, status;
   final GestureTapCallback press;
   final List labinfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                bookingCard(
                  name: name,
                  labName: labName,
                  date: date,
                  time: time,
                  id: id,
                  status: status,
                  press : press,
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
