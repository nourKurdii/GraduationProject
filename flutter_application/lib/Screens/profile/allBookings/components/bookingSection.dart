import 'package:flutter/material.dart';
import 'bookingCard.dart';
import 'package:objectid/objectid.dart';

class bookingSection extends StatelessWidget {
  const bookingSection({
    Key? key,
    required this.name,
    required this.labName,
    required this.time,
    required this.date,
    required this.press,
    required this.id,
    required this.status,
  }) : super(key: key);
  final String name, labName, time, date;
  final GestureTapCallback press;
  final String id, status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          SizedBox(
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
                    press: press),
                SizedBox(
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
