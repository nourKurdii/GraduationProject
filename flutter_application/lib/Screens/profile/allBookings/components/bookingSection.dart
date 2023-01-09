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
    required this.id,
    required this.status,
  }) : super(key: key);
  final String name, labName, time, date;
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
                    ),
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
